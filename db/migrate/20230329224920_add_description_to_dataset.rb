class AddDescriptionToDataset < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :description, :text
  end
end
