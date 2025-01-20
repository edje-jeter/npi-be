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

ActiveRecord::Schema[8.0].define(version: 2025_01_20_132430) do
  create_table "providers", force: :cascade do |t|
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "country_code"
    t.string "country_name"
    t.string "credential"
    t.string "name_first"
    t.string "name_last"
    t.string "name_middle"
    t.string "name_organization"
    t.string "npi"
    t.string "nppes_last_updated"
    t.string "nppes_type"
    t.string "postal_code"
    t.string "primary_taxonomy"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_pulled_from_nppes_at", null: false
    t.index ["npi"], name: "index_providers_on_npi", unique: true
  end
end
