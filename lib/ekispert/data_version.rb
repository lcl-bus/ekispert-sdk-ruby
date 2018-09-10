module Ekispert
  class DataVersion
    extend Ekispert::Util
    attr_accessor :version_list, :copyrights_list

    def initialize
      @version_list = []
      @copyrights_list = []
    end

    def self.get
      to_data_version(Ekispert::Client.get('dataversion'))
    end

    def self.to_data_version(elem_arr)
      data_version = self.new
      elem_arr.children.each do |element|
        elem_name = element.name.to_sym
        next unless self.constants.include?(elem_name)

        # Ex. Ekispert::DataVersion::Version.new
        sub_instance = self.const_get(elem_name).new(element)
        class_list_name = "#{snakecase(elem_name)}_list"
        # Ex. data_version.version_list << sub_instance
        data_version.send(class_list_name) << sub_instance
      end
      data_version
    end

    private_class_method :to_data_version

    class Version < EkispertBase; end
    class Copyrights < EkispertBase; end
  end
end
