class AddStripePriceIdToDatasets < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :stripe_price_id, :string
  end
end
