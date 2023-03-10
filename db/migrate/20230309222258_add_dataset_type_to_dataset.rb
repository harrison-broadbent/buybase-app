class AddDatasetTypeToDataset < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :dataset_type, :integer
  end
end
