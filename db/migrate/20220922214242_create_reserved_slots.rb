class CreateReservedSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :reserved_slots do |t|
      t.string :reservation_name, null: false
      t.datetime :start_time, null: false, index: true
      t.datetime :end_time, null: false, index: true
      t.references :warehouse, null: false, foreign_key: true, index: true
      t.uuid :uuid, default: 'gen_random_uuid()', index: true

      t.timestamps
    end
  end
end
