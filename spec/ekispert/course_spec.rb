require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    # From: Tokyo , To: Chiba
    context 'params = { viaList: "22828:22361" }' do
      let(:course_list) { Ekispert::Course.get(viaList: '22828:22361') }
      it 'return Array and contain Ekispert::Course instance' do
        expect(course_list[0].class).to eq Ekispert::Course
      end
    end
  end
  describe '.to_course' do
    # From: Tokyo, To: Chiba
    context 'use course/simple_search.xml' do
      let(:xml) { read_xml('course/simple_search.xml') }
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
      let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
      let(:course) { course_list[0] }
      it 'return Array and contains two elements' do
        expect(course_list.size).to eq 2
      end
      describe 'Course instance' do
        describe '#search_type' do
          it 'return departure' do
            expect(course.search_type).to eq 'departure'
          end
        end
        describe '#route_list' do
          it 'return Array and contains Course::Route instance' do
            expect(course.route_list[0].class).to eq Ekispert::Course::Route
          end
        end
        describe '#price_list' do
          it 'return Array and contains Course::Price instance' do
            expect(course.price_list[0].class).to eq Ekispert::Course::Price
          end
        end
        describe '#pass_status_list' do
          let(:course) { course_list[1] }
          it 'return Array and contains Course::PassStatus instance' do
            expect(course.pass_status_list[0].class).to eq Ekispert::Course::PassStatus
          end
        end
        describe '#serialize_data_list' do
          it 'return Array and contains Course::SerializeData instance' do
            expect(course.serialize_data_list[0].class).to eq Ekispert::Course::SerializeData
          end
        end
        describe '#route' do
          it 'should return Ekispert::Course::Route instance' do
            expect(course_list[0].route.class).to eq Ekispert::Course::Route
          end
        end
        describe '#serialize_data' do
          it 'should return value of Ekispert::Course::SerializeData#text' do
            expect(course_list[0].serialize_data).to match(/^VkV4QaECp6/)
          end
        end
      end
    end
  end
  describe '#relate_line_to_price' do
    context 'use course/geo_point_search.xml' do
      let(:xml) { read_xml('course/geo_point_search.xml') }
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
      let(:course) { Ekispert::Course.new(parsed_xml.xpath('//Course')[0]) }
      context 'course.route_list[0].line_list[0]' do
        let(:line) { course.route_list[0].line_list[0] }
        describe '#fare' do
          it 'should return nil' do
            expect(line.fare.class).to eq Ekispert::Course::Price
          end
          it 'can call #name, return correct value' do
            expect(line.fare.name).to eq nil
          end
        end
      end
      context 'course.route_list[0].line_list[1]' do
        let(:line) { course.route_list[0].line_list[1] }
        describe '#fare' do
          it 'can call #oneway, return correct value' do
            expect(line.fare.oneway).to eq 170
          end
          it 'can call #type, return correct value' do
            expect(line.fare.type).to eq 'Fare'
          end
        end
        describe '#teiki1' do
          it 'can call #oneway, return correct value' do
            expect(line.teiki1.oneway).to eq 6300
          end
          it 'can call #revision_status, return correct value' do
            expect(line.teiki1.revision_status).to eq 'latest'
          end
        end
        describe '#teiki3' do
          it 'can call #oneway, return correct value' do
            expect(line.teiki3.oneway).to eq 17960
          end
        end
        describe '#teiki6' do
          it 'can call #oneway, return correct value' do
            expect(line.teiki6.oneway).to eq 34020
          end
        end
      end
      context 'course.route_list[0].line_list[3]' do
        let(:line) { course.route_list[0].line_list[3] }
        describe '#charge' do
          it 'can call #name, return correct value' do
            expect(line.charge.name).to eq '自由席'
          end
          it 'can call #revision_status_comment, return correct value' do
            expect(line.charge.revision_status_comment).to eq 'Dummy'
          end
          it 'can call #round, return correct value' do
            expect(line.charge.round).to eq 9740
          end
        end
      end
    end
  end
  describe '#relate_price_to_line' do
    context 'use course/include_relation_search.xml' do
      let(:xml) { read_xml('course/include_relation_search.xml') }
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
      let(:course) { Ekispert::Course.new(parsed_xml.xpath('//Course')[0]) }
      context 'course.price_list[0]' do
        let(:price) { course.price_list[2] }
        describe '#line_list' do
          it 'should return Array, and it contains two elements' do
            expect(price.line_list.size).to eq 2
          end
          it 'contains Course::Route::Line instance' do
            expect(price.line_list[0].class).to eq Ekispert::Course::Route::Line
          end
          describe 'Course::Route::Line#name_list（Course::Route::Line::Name）' do
            context 'course.line_list[0]' do
              it 'can call #text, return correct value' do
                expect(price.line_list[0].name_list[0].text).to eq 'ＪＲ中央線快速・東京行'
              end
            end
            context 'course.line_list[1]' do
              it 'can call #text, return correct value' do
                expect(price.line_list[1].name_list[0].text).to eq 'ＪＲ山手線外回り・池袋・上野方面'
              end
            end
          end
        end
      end
    end
  end
  describe '#define_summary_method' do
    context 'use course/include_relation_search.xml' do
      let(:xml) { read_xml('course/include_relation_search.xml') }
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
      let(:course) { Ekispert::Course.new(parsed_xml.xpath('//Course')[0]) }
      describe 'created Ekispert::Course instance' do
        describe '#fare' do
          it 'should return Course::Price instance of fare summary' do
            expect(course.fare.kind).to eq 'FareSummary'
          end
        end
        describe '#charge' do
          it 'should return empty Course::Price instance' do
            expect(course.charge.oneway).to eq 0
          end
        end
        describe '#teiki1' do
          it 'should return Course::Price instance of teiki1 summary' do
            expect(course.teiki1.kind).to eq 'Teiki1Summary'
          end
        end
        describe '#teiki3' do
          it 'should return Course::Price instance of teiki3 summary' do
            expect(course.teiki3.kind).to eq 'Teiki3Summary'
          end
        end
        describe '#teiki6' do
          it 'should return Course::Price instance of teiki6 summary' do
            expect(course.teiki6.kind).to eq 'Teiki6Summary'
          end
        end
      end
    end
  end
end
