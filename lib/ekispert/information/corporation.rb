module Ekispert
  class Information::Corporation < EkispertBase
    attr_reader :name_list
    attr_accessor :line_list

    def initialize(element)
      @name_list = []
      @line_list = [] # Use Information#relate_line_and_corporation
      super(element)
    end

    def name
      @name_list[0].text
    end

    class Name < EkispertBase; end
  end
end
