class FixtureHelper
  class << self
    def setup
      users = [
        'jack@example.com',
        'ashley@example.com',
        'takeshi@exmaple.com',
      ].map do |email|
        User.create!(
          username: email.split('@').first,
          email: email
        )
      end

      [
        File.read(Rails.root.join('spec', 'fixtures', 'seeds', 'geolocation-1.json')),
        File.read(Rails.root.join('spec', 'fixtures', 'seeds', 'geolocation-2.json')),
        File.read(Rails.root.join('spec', 'fixtures', 'seeds', 'geolocation-3.json'))
      ].each do |json|
        params = JSON.parse(json)
        g = Geolocation.from('ipstack', params)
        g.ip_or_hostname = params['ip']
        g.user = users.first
        g.save!
      end
    end

    def teardown
      Geolocation.destroy_all
      User.destroy_all
    end
  end
end
