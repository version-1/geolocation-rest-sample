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

ActiveRecord::Schema[7.2].define(version: 2024_09_02_192953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "geolocations", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.bigint "user_id", null: false
    t.string "provider_code", null: false
    t.string "ip_or_hostname", null: false
    t.string "ip_address", null: false
    t.string "ip_type", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "continent_code", null: false
    t.string "continent_name", null: false
    t.string "country_code", null: false
    t.string "country_name", null: false
    t.string "region_code", null: false
    t.string "region_name", null: false
    t.string "city", null: false
    t.string "zip", null: false
    t.string "radius"
    t.string "msa"
    t.string "dma"
    t.string "currency_code"
    t.string "timezone_code"
    t.jsonb "raw_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_or_hostname", "ip_address"], name: "index_geolocations_on_ip_or_hostname_and_ip_address", unique: true
    t.index ["user_id"], name: "index_geolocations_on_user_id"
    t.index ["uuid"], name: "index_geolocations_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["password_digest"], name: "index_users_on_password_digest"
    t.index ["username"], name: "index_users_on_username", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end
end
