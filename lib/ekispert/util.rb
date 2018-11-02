module Ekispert
  module Util
    # Ex. snakecase('GeoPoint') #=> 'geo_point'
    def snakecase(str)
      str = str.to_s
      return str unless /[A-Z-]/.match?(str)

      words = str.split(/(JR|CO2|IC)/).reject(&:empty?)
      words.map { |word| word.gsub(/([a-z\d])([A-Z])/, '\1_\2') }.join('_').downcase
    end
  end
end
