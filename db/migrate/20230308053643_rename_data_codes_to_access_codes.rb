class RenameDataCodesToAccessCodes < ActiveRecord::Migration[7.0]
  def change
    rename_table :data_codes, :access_codes
  end
end
