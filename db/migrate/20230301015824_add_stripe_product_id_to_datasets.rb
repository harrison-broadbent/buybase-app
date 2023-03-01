class AddStripeProductIdToDatasets < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :stripe_product_id, :string
  end
end
