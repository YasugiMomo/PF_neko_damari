# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'google_places'
require 'dotenv'

Dotenv.load
client = GooglePlaces::Client.new ENV['GOOGLE_API_KEY']

data = client.spots_by_query('東京都 猫カフェ', language: 'ja')

# 取得した情報をplaceという変数に格納
data.each do |place|

  Shop.create(
    name: place.name,
    address: place.formatted_address,
    phone_number: place.international_phone_number,
    website: place.website
  )

end

# Adminのデータ
Admin.create!(
  email: "yasugimomo.crw@gmail.com",
  password: "yasugi202203"
)

