class AddDatabaseUrlToDataset < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :database_url, :string
  end
end
