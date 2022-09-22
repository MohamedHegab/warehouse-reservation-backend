# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_22_214242) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "business_hours", force: :cascade do |t|
    t.bigint "warehouse_id", null: false
    t.integer "day", null: false
    t.string "open_time", null: false
    t.string "close_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["warehouse_id", "day"], name: "index_business_hours_on_warehouse_id_and_day", unique: true
    t.index ["warehouse_id"], name: "index_business_hours_on_warehouse_id"
  end

  create_table "reserved_slots", force: :cascade do |t|
    t.string "reservation_name", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.bigint "warehouse_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_time"], name: "index_reserved_slots_on_end_time"
    t.index ["start_time"], name: "index_reserved_slots_on_start_time"
    t.index ["uuid"], name: "index_reserved_slots_on_uuid"
    t.index ["warehouse_id"], name: "index_reserved_slots_on_warehouse_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "business_hours", "warehouses"
  add_foreign_key "reserved_slots", "warehouses"
end
