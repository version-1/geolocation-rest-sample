class CreateGeolocationProviderIpstackLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :geolocation_provider_ipstack_locations do |t|
      t.timestamps
    end
  end
end
