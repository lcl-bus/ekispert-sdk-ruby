module Ekispert
  module Util
    # Ex. snakecase('GeoPoint') #=> 'geo_point'
    def snakecase(str)
      str = str.to_s
      return str unless /[A-Z-]/.match?(str)
      str.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
    end
  end
end
