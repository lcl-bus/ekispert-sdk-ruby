module Ekispert
  class DataVersion
    attr_accessor :version_list, :copyright_list

    def initialize
      @version_list = []
      @copyright_list = []
    end

    def self.get
      to_data_version(Ekispert::Client.get('/dataversion'))
    end

    class Version; end
    class Copyright; end

    private
    def self.to_data_version(elem_arr)
      data_version = DataVersion.new
      elem_arr.children.each do |element|
        subclass_name = find_subclass(element.name) || next
        subclass_instance = create_subclass_instance(element, subclass_name)
        set_instance_variable(data_version, subclass_instance)
      end
      data_version
    end

    def self.find_subclass(name)
      case name
      when 'Version'
        :Version
      when 'Copyrights'
        :Copyright
      else
        nil
      end
    end

    # ex. Ekispert::DataVersion::Version.new
    def self.create_subclass_instance(element, subclass_name)
      instance = DataVersion.const_get(subclass_name).new
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
      attributes.each do |name, attr|
        instance.class.class_eval { attr_accessor name }
        instance.instance_variable_set("@#{name}", attr.value)
      end
    end

    def self.set_method_from_text(text, instance)
      instance.class.class_eval { attr_accessor :text }
      instance.instance_variable_set('@text', text)
      instance.instance_eval { alias :to_s :text }
    end

    # Ex.
    # #<Ekispert::DataVersion @version_list=[], @copyright_list=[]>
    # -> @version_list=[
    #      #<Ekispert::DataVersion::Version @...>,
    #      <Ekispert::DataVersion::Version @...>
    #    ],
    # -> @copyright_list=[
    #      #<Ekispert::DataVersion::Copyright @...>,
    #      <Ekispert::DataVersion::Copyright @...>
    #    ],
    def self.set_instance_variable(base_instance, instance)
      if instance.class == Ekispert::DataVersion::Version
        base_instance.version_list << instance
      elsif instance.class == Ekispert::DataVersion::Copyright
        base_instance.copyright_list << instance
      end
    end
  end
end
