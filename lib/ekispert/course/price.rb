module Ekispert
  class Course::Price < EkispertBase
    attr_accessor :name_list, :oneway_list, :rate_list, :round_list
    attr_accessor :revision_status_list, :revision_status_comment_list, :type_list
    attr_accessor :line_list, :pass_status

    def initialize(element=nil)
      @name_list = []
      @oneway_list = []
      @rate_list = []
      @round_list = []
      @revision_status_list = []
      @revision_status_comment_list = []
      @type_list = []
      @line_list = [] # Use Course#relate_price_to_line
      return if element.nil?

      super(element)
    end

    def name
      @name_list[0]&.text
    end

    def oneway
      @oneway_list[0]&.text.to_i
    end

    def rate
      @rate_list[0]&.text.to_i
    end

    def round
      @round_list[0]&.text.to_i
    end

    def revision_status
      @revision_status_list[0]&.text
    end

    def revision_status_comment
      @revision_status_comment_list[0]&.text
    end

    def type
      @type_list[0]&.text
    end

    def fare?
      kind == 'Fare'
    end

    def charge?
      kind == 'Charge'
    end

    def teiki?
      kind.match?(/^Teiki\d{1,2}$/)
    end

    class Name < EkispertBase; end
    class Oneway < EkispertBase; end
    class Rate < EkispertBase; end
    class Round < EkispertBase; end
    class RevisionStatus < EkispertBase; end
    class RevisionStatusComment < EkispertBase; end
    class Type < EkispertBase; end
  end
end
