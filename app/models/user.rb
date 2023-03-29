# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                               :bigint           not null, primary key
#  email                            :string           default(""), not null
#  encrypted_password               :string           default(""), not null
#  image                            :string
#  name                             :string
#  provider                         :string
#  remember_created_at              :datetime
#  reset_password_sent_at           :datetime
#  reset_password_token             :string
#  stripe_checkout_percentage_fee   :float
#  stripe_connected_account_success :boolean
#  uid                              :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  connected_account_id             :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]

  has_many :datasets, dependent: :destroy
  has_many :access_codes, dependent: :destroy

  after_create :stripe_create_connected_account

  ### Stripe methods ##
  def stripe_create_connected_account
    # create stripe connected account for the user
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    acc = Stripe::Account.create({type: 'standard'})

    self.connected_account_id = acc.id
    self.stripe_connected_account_success = false
    self.stripe_checkout_percentage_fee = 0.05 # 5% application fee applied to all purchases

    self.save
  end

  def stripe_generate_new_account_link
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    account_link = Stripe::AccountLink.create({
                                                account: self.connected_account_id,
                                                refresh_url: "http://localhost:3000",
                                                return_url: "http://localhost:3000/users/#{self.id}",
                                                type:"account_onboarding"
                                              })
    return account_link
  end

  def stripe_get_account
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    account = Stripe::Account.retrieve(self.connected_account_id)
    return account
  end

  def total_dataset_views_last_n_days(n)
    datasets_views = datasets.map do |dataset|
      dataset.views_past_n_days(n)
    end

    # Merge all hashes into a single hash with summed values
    merged_views = datasets_views.reduce do |result, views|
      result.merge(views) { |key, v1, v2| v1 + v2 }
    end

    # Create a hash with all dates within the last 7 days and set the value to 0 by default
    dates = (0..n-1).map { |i| i.days.ago.to_date }
    empty_events_by_date = Hash[dates.map { |date| [date.strftime("%Y-%m-%d"), 0] }]

    # Merge the empty hash with the events hash to get the final result
    empty_events_by_date.merge(merged_views) { |key, empty_value, views_value| views_value }
  end

  ###

  # Devise methods
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
