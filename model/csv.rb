require 'csv'

require './tootor.rb'
require './db.rb'

CSV.foreach('tootors.csv', headers: true) do |row|
  t = Tootor.new

  t.is_tootor = row[0].downcase == 'true'
  t.username = row[1]
  t.seo_name= row[2]
  t.email = row[3]
  t.password = row[4]
  t.name = row[5]
  t.phone = row[6]
  t.price = row[7]
  t.street = row[8]
  t.city = row[9]
  t.state = row[10]
  t.zip = row[11]
  t.focus = row[12]
  t.description = row[13]
  # t.picture = row[14]
  t.video = row[15]

  # p t

  TootorsDb.insert t
end
