class CreateBusinessHours < ActiveRecord::Migration[7.0]
  def change
    create_table :business_hours do |t|
      t.references :warehouse, null: false, foreign_key: true
      t.integer :day, null: false
      t.string :open_time, null: false
      t.string :close_time, null: false

      t.timestamps
    end

    add_index :business_hours, %i[warehouse_id day], unique: true
  end
end
