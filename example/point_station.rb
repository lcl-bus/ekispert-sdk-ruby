require 'ekispert'

station_list = Ekispert::Point::Station.get(code:'22828', addGateGroup: true)
station = station_list[0]
puts "Station: #{station.name}"
puts "Latitude: #{station.geo_point.lati_d}"
puts "Longitude: #{station.geo_point.longi_d}"
station.gate_group_list.each do |gate_group|
  gate_group.gate_list.each do |gate|
    puts "Gate: #{gate.name}"
  end
end

# Station: 東京
# Latitude: 35.678083
# Longitude: 139.770444
# Gate: 京葉線1(北側)
# Gate: 京葉線1(南側)
# Gate: 京葉線2
# ... and more
