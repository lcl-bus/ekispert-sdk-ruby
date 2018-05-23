module Ekispert
  module Util
    module_function

    # Ex. snakecase('GeoPoint') #=> 'geo_point'
    def snakecase(str)
      return str unless /[A-Z-]/.match?(str)
      str.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
    end

    # argument:
    #   attributes : XML attributes (parsed Nokogiri)
    #   instance   : modified instance
    #
    # Ex. DataVersion class
    # argument:
    #   attributes = {
    #     "create"     => #(Attr:0x3fe7b6a050a4 { name = "create", value = "20180502" }),
    #     "createType" => #(Attr:0x3fe7b6a05090 { name = "createType", value = "Edition" }),
    #     "caption"    => #(Attr:0x3fe7b6a0507c { name = "caption", value = "知識ベース" })
    #   }
    #   instance = Ekispert::DataVersion.new
    # result:
    #   instance.create      #=> '20180502'
    #   instance.create_type #=> 'Edition'
    #   instance.caption     #=> '知識ベース'
    def set_methods_from_attributes(attributes, instance)
      attributes.each do |name, attribute|
        name = snakecase(name)
        instance.class.class_eval { attr_accessor name }
        instance.instance_variable_set("@#{name}", attribute.value)
      end
    end

    # argument:
    #   text     : XML text node
    #   instance : modified instance
    #
    # Ex. Station::Name class
    # argument:
    #   text = '東京'
    #   instance = Ekispert::Point::Station::Name.new
    # result:
    #   instance.text #=> '東京'
    #   instance.to_s #=> '東京'
    def set_method_from_text(text, instance)
      instance.class.class_eval { attr_accessor :text }
      instance.instance_variable_set('@text', text)
      instance.instance_eval { alias :to_s :text }
    end

    # argument:
    #   base_instance : modified instance
    #   sub_instance  : child elemment instance
    #
    # Ex. DataVersion class (child element name is Version)
    # argument:
    #   base_instance = Ekispert::DataVersion.new
    #   sub_instance = Ekispert::DataVersion::Version.new
    # result:
    #   #<Ekispert::DataVersion @version_list = [], @copyrights_list = []>
    #   -> @version_list = [
    #        #<Ekispert::DataVersion::Version @...>
    #      ]
    def update_class_list_variable(base_instance, sub_instance)
      class_name = sub_instance.class.to_s.split('::').last
      class_list_name = "#{snakecase(class_name)}_list"
      # Ex. base_instance.version_list << sub_instance
      base_instance.send(class_list_name) << sub_instance
    end
  end
end
