module Ekispert
  class Information

    def self.get(code, types)
      options = {code: code, type: types}
      to_ekispert_class(Ekispert::Client.get('/station/info', options), types)
    end

    class Line; end
    class Corporation; end
    class WelfareFacilities; end
    class Exit; end
    class Type; end

    private
    def self.to_ekispert_class(elem_arr, types)
      information = Information.new
      element_list = []
      # ex.[type,line,corporation]
      create_element_list(element_list, elem_arr.children)
      # ex.@type_list,@line_list,@corporation_list
      variable_definition(information, element_list)
      elem_arr.children.each do |elements|
        base_type = get_basetype_name(elements)
        elements.children.each do |element|
          subclass_name = element.name
          subclass_instance = create_subclass_instance(element, subclass_name, base_type)
          push_self_instance(information, subclass_instance, subclass_name)
        end
      end
      information
    end

    def self.variable_definition(information, element_list)
      element_list.each do |element|
        information.instance_variable_set("@#{element}_list", [])
        information.class.class_eval { attr_accessor :"#{element}_list" }
      end
    end

    def self.get_basetype_name (elements)
      elements.children.each do |element|
        if element.name == "Type"
         return element.text.capitalize
        end
      end
    end

    def self.create_element_list (element_list, elements)
      elements.children.each do |element|
        if element_list.include?(element.name)
          next
        else
          element_list << element.name.downcase
        end
      end
    end

    def self.create_subclass_instance(element, subclass_name, base_type)
      instance = Information.const_get(subclass_name).new
      set_methods_from_element(element, instance, base_type)
    end

    def self.set_methods_from_element(element, instance, base_type)
      element.children.each do |elem|
        if elem.name == "text"
          instance.class.class_eval { attr_accessor :name }
          instance.instance_variable_set("@name", elem.text)
        end
        instance.class.class_eval { attr_accessor elem.name.downcase }
        instance.instance_variable_set("@#{elem.name.downcase}", elem.children.text)
      end
      instance.class.class_eval { attr_accessor :basetype }
      instance.instance_variable_set("@basetype", base_type)
      instance
    end

    def self.push_self_instance(information, instance, subclass_name)
      eval("information.#{subclass_name.downcase}_list << instance")
    end
  end
end
