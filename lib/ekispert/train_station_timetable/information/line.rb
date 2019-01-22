module Ekispert
  class TrainStationTimetable < EkispertBase
    class Information < EkispertBase
      class Line < EkispertBase
        attr_reader :name_list, :guide_comment_list
        attr_reader :type_list, :drive_comment_list

        def initialize(element)
          @name_list = []
          @guide_comment_list = []
          @type_list = []
          @drive_comment_list = []
          super(element)
        end

        def name
          @name_list[0].text
        end

        def guide_comment
          @guide_comment_list[0].text
        end

        def type
          @type_list[0].text
        end

        def drive_comment
          @drive_comment_list[0].text
        end

        class Name < EkispertBase; end
        class GuideComment < EkispertBase; end
        class Type < EkispertBase; end
        class DriveComment < EkispertBase; end
      end
    end
  end
end
