module Ekispert
  class DataVersion
    attr_accessor :version_list, :copyrights_list

    def initialize
      @version_list = []
      @copyrights_list = []
    end

    def self.get
      to_data_version(Ekispert::Client.get('/dataversion'))
    end

    class Version; end
    class Copyrights; end

    private

    def self.to_data_version(elem_arr)
      data_version = self.new
      elem_arr.children.each do |element|
        elem_name = element.name.to_sym
        next unless self.constants.include?(elem_name)
        subclass_instance = create_subclass_instance(element, elem_name)
        set_instance_variable(data_version, subclass_instance)
      end
      data_version
    end

    # ex. Ekispert::DataVersion::Version.new
    def self.create_subclass_instance(element, subclass_name)
      instance = self.const_get(subclass_name).new
      # attribute
      if element.attributes.size > 0
        set_methods_from_attributes(element.attributes, instance)
      end
      # text node
      if (child_elem = element.children[0]) && child_elem.text?
        set_method_from_text(child_elem.text, instance)
      end
      instance
    end

    def self.set_methods_from_attributes(attributes, instance)
      attributes.each do |name, attribute|
        instance.class.class_eval { attr_accessor name }
        instance.instance_variable_set("@#{name}", attribute.value)
      end
    end

    def self.set_method_from_text(text, instance)
      instance.class.class_eval { attr_accessor :text }
      instance.instance_variable_set('@text', text)
      instance.instance_eval { alias :to_s :text }
    end

    # Ex.
    # #<Ekispert::DataVersion @version_list=[], @copyrights_list=[]>
    # -> @version_list=[
    #      #<Ekispert::DataVersion::Version @...>,
    #      <Ekispert::DataVersion::Version @...>
    #    ],
    # -> @copyrights_list=[
    #      #<Ekispert::DataVersion::Copyrights @...>,
    #      <Ekispert::DataVersion::Copyrights @...>
    #    ],
    def self.set_instance_variable(base_instance, instance)
      if instance.is_a?(Ekispert::DataVersion::Version)
        base_instance.version_list << instance
      elsif instance.is_a?(Ekispert::DataVersion::Copyrights)
        base_instance.copyrights_list << instance
      end
    end
  end
end
