class AddPriceToDataset < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :price, :string
  end
end
