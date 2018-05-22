module Ekispert
  class Information
    attr_accessor :line_list, :corporation_list, :welfarefacilities_list, :exit_list, :type_list

    def initialize
      @line_list = []
      @corporation_list = []
      @welfarefacilities_list = []
      @exit_list = []
      @type_list = []
    end

    def self.get(code, types)
      options = { code: code, type: types }
      to_ekispert_class(Ekispert::Client.get('/station/info', options), types)
    end

    class Line; end
    class Corporation; end
    class WelfareFacilities; end
    class Exit; end
    class Type; end

    private

    def self.to_ekispert_class(elem_arr, _types)
      information = self.new

      elem_arr.children.each do |elements|
        base_type = get_basetype_name(elements)
        elements.children.each do |element|
          subclass_name = element.name

          subclass_instance = create_subclass_instance(element, subclass_name, base_type)

          push_self_instance(information, subclass_instance)
        end
      end
      information
    end

    def self.get_basetype_name(elements)
      elements.children.each do |element|
        if element.name == 'Type'
          return element.text.capitalize
        end
      end
    end

    def self.create_subclass_instance(element, subclass_name, base_type)
      instance = self.const_get(subclass_name).new
      set_methods_from_element(element, instance, base_type)
    end

    def self.set_methods_from_element(element, instance, base_type)
      element.children.each do |elem|
        if elem.name == 'text'
          instance.class.class_eval { attr_accessor :name }
          instance.instance_variable_set('@name', elem.text)
        end
        instance.class.class_eval { attr_accessor elem.name.downcase }
        instance.instance_variable_set("@#{elem.name.downcase}", elem.children.text)
      end
      instance.class.class_eval { attr_accessor :basetype }
      instance.instance_variable_set('@basetype', base_type)
      instance
    end

    def self.push_self_instance(base_instance, instance)
      case instance
      when Ekispert::Information::Line
        base_instance.line_list << instance
      when Ekispert::Information::Corporation
        base_instance.corporation_list << instance
      when Ekispert::Information::WelfareFacilities
        base_instance.welfareFacilities_list << instance
      when Ekispert::Information::Exit
        base_instance.exit_list << instance
      when Ekispert::Information::Type
        base_instance.type_list << instance
      end
    end
  end
end
