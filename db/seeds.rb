# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  File.read(Rails.root.join('spec', 'fixtures', 'seeds', 'geolocation-1.json')),
  File.read(Rails.root.join('spec', 'fixtures', 'seeds', 'geolocation-2.json')),
  File.read(Rails.root.join('spec', 'fixtures', 'seeds', 'geolocation-3.json'))
].each do |json|
  params = JSON.parse(json)
  g = Geolocation.from('ipstack', params)
  g.ip_or_hostname = params['ip']
  g.save!
end
