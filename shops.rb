require 'google_places'
require 'dotenv'
require 'csv'

Dotenv.load
client = GooglePlaces::Client.new ENV['GOOGLE_API_KEY']

data = client.spots_by_query('東京都 猫カフェ', language: 'ja')

# 取得した情報をplaceという変数に格納
CSV.open('shops.csv', 'w') do |csv|

  
  data.each do |place|
    csv << [place.name, place.formatted_address]
  end

end
