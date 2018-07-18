module Ekispert
  class Course < EkispertBase
    attr_accessor :route_list, :price_list, :pass_status_list, :serialize_data_list
    attr_accessor :fare, :charge, :teiki1, :teiki3, :teiki6

    def initialize(element)
      @route_list = []
      @price_list = []
      @pass_status_list = []
      @serialize_data_list = []
      super(element)
      define_summary_method
      relate_line_to_price
      relate_price_to_line
      relate_price_and_pass_status
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

    # This method define summary methods.
    # If nothing 'HogeSummary' elements, create and set empty Course::Price instance.
    # result:
    #   Course#fare
    #   Course#charge
    #   Course#teiki1 ...
    def define_summary_method
      %w[fare charge teiki1 teiki3 teiki6].each do |summary_type|
        self.define_singleton_method(summary_type) { price_summary(summary_type) }
      end
    end

    def price_summary(type)
      @price_list.find { |price| price.kind == "#{type.capitalize}Summary" } || Ekispert::Course::Price.new
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

    # This method relate Course::Price instance and Course::PassStatus instance.
    # It's judged based on to Price#pass_class_index.
    # result:
    #   Course::Price#pass_status
    def relate_price_and_pass_status
      price_list.each do |price|
        next unless price.kind.match?(/^Teiki\d{1}$/)
        pass_status = find_pass_status(price)
        # Price to PassStatus
        price.pass_status = pass_status
        # PassStatus to Price
        pass_status.price_list << price
      end
    end

    def find_pass_status(price)
      return Ekispert::Course::PassStatus.new unless price.respond_to?(:pass_class_index)
      @pass_status_list.find { |status| status.index == price.pass_class_index }
    end
  end
end
