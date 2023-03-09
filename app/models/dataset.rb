# == Schema Information
#
# Table name: datasets
#
#  id                :bigint           not null, primary key
#  name              :string
#  price             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_price_id   :string
#  stripe_product_id :string
#  user_id           :bigint           not null
#
# Indexes
#
#  index_datasets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
class Dataset < ApplicationRecord
  belongs_to :user
  has_one_attached :file, dependent: :destroy
  has_many :access_codes, dependent: :destroy

  after_create :stripe_create_dataset_product

  # create corresponding stripe product and price
  def stripe_create_dataset_product
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    product = Stripe::Product.create({
                             name: self.name,
                             default_price_data: {
                               unit_amount: (self.price.to_f * 100).to_i, #stripe uses price in cents
                               currency: 'usd',
                             }
                           },
                           {stripe_account: self.user.connected_account_id}
    )

    self.stripe_product_id = product.id
    self.stripe_price_id = product.default_price
    self.save
  end

  def stripe_create_checkout_session
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    session =  Stripe::Checkout::Session.create({
                                       mode: 'payment',
                                       line_items: [{price: self.stripe_price_id, quantity: 1}],
                                       # take a percentage fee of each transaction
                                       payment_intent_data: {application_fee_amount: ((self.price.to_f * self.user.stripe_checkout_percentage_fee) * 100).to_i},
                                       success_url: "http://localhost:3000/checkout_success?session_id={CHECKOUT_SESSION_ID}&user_id=#{self.user.id}&dataset_id=#{self.id}",
                                       cancel_url: "http://localhost:3000/datasets/#{self.id}"
                                     },
                                     {stripe_account: self.user.connected_account_id}
    )
    return session.url
  end

  def access_code_is_valid?(access_code)
    access_codes = AccessCode.where(code: access_code).pluck(:id)
    # if the intersection of access_codes and self.access_code_ids is not empty, the code is valid
    return (self.access_code_ids & access_codes).present?
  end

end
