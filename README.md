# ekispert

A module for using the EkispertWebService API.

## Installation

Add this line to your application's Gemfile:

```
gem 'ekispert-sdk-ruby', :git => 'git@github.com:EkispertWebService/ekispert-sdk-ruby.git'
```

or

```
gem 'ekispert-sdk-ruby',  :github => 'EkispertWebService/ekispert-sdk-ruby'
```

## Settings

```
$ echo export EKISPERT_API_KEY=api_key >> ~/.bash_profile

# If you need to access Web through proxy
$ echo export HTTP_PROXY="http://www.example.com:8080" >> ~/.bash_profile

$ source ~/.bash_profile

$ bundle install
```

## Trial use

Don't forget to require ekispert.

```ruby
require 'ekispert'
```

### Search Station

The base of this module is its `/v1/xml/station` API.
[-> Ekispert web service reference.](http://docs.ekispert.com/v1/api/station.html)

```ruby
station_list = Ekispert::Point::Station.get(code: '22828')

p station_list[0].name
#=> "東京"

p station_list[0].prefecture.name
#=> "東京都"

jr_station_list = Ekispert::Point::Station.get(corporationName: 'JＲ', limit: 2)

p jr_station_list[0].name
#=> "相生(兵庫県)"

p jr_station_list[1].name
#=> "相賀"
```

### Search Course

The base of this module is its `/v1/xml/search/course/extreme` API.
[-> Ekispert web service reference.](http://docs.ekispert.com/v1/api/search/course/extreme.html)

```ruby
course_list = Ekispert::Course.get(viaList: '22828:22741', answerCount: 1)

course_list.each_with_index do |course, i|
  price_list = course.price_list
  route = course.route
  point_list = route.point_list
  line_list = route.line_list

  line_list.each_with_index do |line, j|
    puts "#{line.departure_state.datetime.strftime('%H:%M')} #{point_list[j].station.name}"
    if line.line_symbol
      puts " | [#{line.line_symbol.name}] #{line.name}"
    else
      puts " | #{line.name}"
    end
  end
  puts "#{line_list[-1].arrival_state.datetime.strftime('%H:%M')} #{point_list[-1].station.name}"
end

# 12:00 東京
#  | [JC] ＪＲ中央線中央特快・高尾行
# 12:16 新宿
```

And more...

If you want to see more sample code, see the `/example` directory.

## Supported Ruby Versions
This library supports and is tested against the following Ruby inplementations:
- Ruby 2.5.0

## Document
[Ekispert web service reference](http://docs.ekispert.com/v1/api/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/EkispertWebService/ekispert-sdk-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
