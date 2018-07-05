module Ekispert
  class Course < EkispertBase
    attr_accessor :route_list, :price_list, :pass_status_list, :serialize_data_list

    def initialize(element)
      @route_list = []
      @price_list = []
      @pass_status_list = []
      @serialize_data_list = []
      super(element)
      relate_line_to_price
      relate_price_to_line
    end

    def route
      @route_list[0]
    end

    def serialize_data
      @serialize_data_list[0].text
    end

    def self.get(**params)
      to_course(Ekispert::Client.get('search/course/extreme', params))
    end

    private

    def self.to_course(elem_arr)
      elem_arr.xpath('//Course').map { |course_elem| self.new(course_elem) }
    end

    # This method relate Course::Route::Line instance to Course::Price instance.
    # If even without those associated with Line, return Price instance.
    # Ex.
    #  Course::Route::Line#fare
    #  Course::Route::Line#charge
    #  Course::Route::Line#teiki1 etc...
    def relate_line_to_price
      @route_list[0].line_list.each do |line|
        line.fare = find_price(line, :fare)
        line.charge = find_price(line, :charge)
        line.teiki1 = find_price(line, :teiki1)
        line.teiki3 = find_price(line, :teiki3)
        line.teiki6 = find_price(line, :teiki6)
      end
    end

    def find_price(line, price_type)
      index_type = "#{price_type}_index"
      return Ekispert::Course::Price.new unless line.respond_to?(index_type)
      kind = price_type.to_s.capitalize
      @price_list.find { |price| price.kind == kind && price.index == line.send(index_type) }
    end

    # This method relate Course::Price instance to Course::Route::Line instance.
    # It's judged based on to Price#from_line_index and Price#from_line_index.
    # result:
    #   Course::Price#line_list
    def relate_price_to_line
      @price_list.each do |price|
        next unless price.respond_to?(:from_line_index)
        price_range = (price.from_line_index.to_i..price.to_line_index.to_i)
        price.line_list = @route_list[0].line_list.select { |line| price_range.include?(line.index.to_i) }
      end
    end
  end
end
