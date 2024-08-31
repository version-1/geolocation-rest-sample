class CreateGeolocations < ActiveRecord::Migration[7.2]
  def change
    create_table :geolocations do |t|
      t.uuid :uuid, default: -> { 'gen_random_uuid()' }, null: false
      t.string :provider_code, null: false

      t.string :ip_address, null: false
      t.string :ip_type, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.string :continent_code, null: false
      t.string :continent_name, null: false
      t.string :country_code, null: false
      t.string :country_name, null: false
      t.string :region_code, null: false
      t.string :region_name, null: false
      t.string :city, null: false
      t.string :zip, null: false

      t.string :radius
      t.string :msa
      t.string :dma

      t.string :timezone_code, null: false
      t.string :currency_code, null: false

      t.jsonb :raw_data, null: false, default: {}

      t.timestamps
    end
  end
end
