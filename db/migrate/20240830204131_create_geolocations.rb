class CreateGeolocations < ActiveRecord::Migration[7.2]
  def change
    create_table :geolocations do |t|
      t.uuid :uuid, default: -> { 'gen_random_uuid()' }, null: false
      t.number :provider_type, null: false
      t.string :provider_id, null: false
      t.string :ip_address, null: false
      t.string :ip_type, null: false
      t.string :continent_code, null: false
      t.string :continent_name, null: false
      t.string :country_code, null: false
      t.string :country_name, null: false
      t.string :region_code, null: false
      t.string :region_name, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
