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

ActiveRecord::Schema[7.2].define(version: 2024_08_31_172037) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "geolocation_provider_ipstack_locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geolocations", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "provider_type", null: false
    t.decimal "provider_id", null: false
    t.string "ip_address", null: false
    t.string "ip_type", null: false
    t.string "continent_code", null: false
    t.string "continent_name", null: false
    t.string "country_code", null: false
    t.string "country_name", null: false
    t.string "region_code", null: false
    t.string "region_name", null: false
    t.string "city", null: false
    t.string "zip", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id", "provider_type"], name: "index_geolocations_on_provider_id_and_provider_type", unique: true
  end

  create_table "geolocations_locations", force: :cascade do |t|
    t.string "geoname_id", null: false
    t.string "capital", null: false
    t.string "country_flag", null: false
    t.string "country_flag_emoji", null: false
    t.string "country_flag_emoji_unicode", null: false
    t.string "calling_code", null: false
    t.boolean "is_eu", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
