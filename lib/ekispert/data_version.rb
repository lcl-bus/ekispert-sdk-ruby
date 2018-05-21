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
        Ekispert::Util.set_instance_variable(data_version, subclass_instance)
      end
      data_version
    end

    # ex. Ekispert::DataVersion::Version.new
    def self.create_subclass_instance(element, subclass_name)
      instance = self.const_get(subclass_name).new
      # attribute
      if element.attributes.size > 0
        Ekispert::Util.set_methods_from_attributes(element.attributes, instance)
      end
      # text node
      if (child_elem = element.children[0]) && child_elem.text?
        Ekispert::Util.set_method_from_text(child_elem.text, instance)
      end
      instance
    end
  end
end
