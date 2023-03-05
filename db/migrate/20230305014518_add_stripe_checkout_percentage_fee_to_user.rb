class AddStripeCheckoutPercentageFeeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_checkout_percentage_fee, :float
  end
end
