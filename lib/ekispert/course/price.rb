module Ekispert
  class Course < EkispertBase
    class Price < EkispertBase
      attr_accessor :name_list, :oneway_list, :rate_list, :round_list
      attr_accessor :revision_status_list, :revision_status_comment_list, :type_list

      def initialize(element)
        @name_list = []
        @oneway_list = []
        @rate_list = []
        @round_list = []
        @revision_status_list = []
        @revision_status_comment_list = []
        @type_list = []
        super(element)
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
end
