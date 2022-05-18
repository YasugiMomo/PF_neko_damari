require 'google_places'
require 'dotenv'

Dotenv.load
client = GooglePlaces::Client.new ENV['GOOGLE_API_KEY']

data = client.spots_by_query('東京都 猫カフェ', language: 'ja')

# 取得した情報をplaceという変数に格納
data.each do |place|

  puts(
    name: place.name,
    address: place.formatted_address,
    phone_number: place.international_phone_number,
    website: place.website
  )

end