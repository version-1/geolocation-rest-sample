class User < ApplicationRecord
  has_many :geolocations

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
