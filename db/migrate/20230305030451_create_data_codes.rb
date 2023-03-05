class CreateDataCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :data_codes do |t|
      t.string :customer_email
      t.references :user, null: false, foreign_key: true
      t.references :dataset, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
