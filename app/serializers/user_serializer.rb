class UserSerializer < ActiveModel::Serializer
  attributes(
    :email,
    :username,
    :created_at,
    :updated_at
  )

  has_many :geolocations

  def id
    object.uuid
  end
end
