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

  after_create :stripe_create_dataset_product

  # create corresponding stripe product
  def stripe_create_dataset_product
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]
    product = Stripe::Product.create({
                             name: self.name,
                             default_price_data: {
                               unit_amount: self.price.to_f * 100, #stripe uses price in cents
                               currency: 'usd',
                             }
                           })

    self.stripe_product_id = product.id
    self.stripe_price_id = product.default_price
    self.save
    
  end

  # create corresponding stripe price for product
end
