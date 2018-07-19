require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Price do
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  describe '.to_course（Price class part）' do
    # From: Tokyo, To: Shin-Osaka
    let(:xml) { read_xml('course/shinkansen_search.xml') }
    let(:price) { course_list[0].price_list[3] }
    describe 'Course::Price instance' do
      describe '#name_list' do
        it 'return Array and contains Course::Price::Name instance' do
          expect(price.name_list[0].class).to eq Ekispert::Course::Price::Name
        end
      end
      describe '#oneway_list' do
        it 'return Array and contains Course::Price::Oneway instance' do
          expect(price.oneway_list[0].class).to eq Ekispert::Course::Price::Oneway
        end
      end
      describe '#rate_list' do
        it 'return Array and contains Course::Price::Rate instance' do
          expect(price.rate_list[0].class).to eq Ekispert::Course::Price::Rate
        end
      end
      describe '#round_list' do
        it 'return Array and contains Course::Price::Round instance' do
          expect(price.round_list[0].class).to eq Ekispert::Course::Price::Round
        end
      end
      describe '#revision_status_list' do
        it 'return Array and contains Course::Price::RevisionStatus instance' do
          expect(price.revision_status_list[0].class).to eq Ekispert::Course::Price::RevisionStatus
        end
      end
      describe '#revision_status_comment_list' do
        it 'return Array and contains Course::Price::RevisionStatusComment instance' do
          expect(price.revision_status_comment_list[0].class).to eq Ekispert::Course::Price::RevisionStatusComment
        end
      end
      describe '#type_list' do
        it 'return Array and contains Course::Price::Type instance' do
          expect(price.type_list[0].class).to eq Ekispert::Course::Price::Type
        end
      end
    end
  end
  context '#kind == "Teiki1Summary"' do
    let(:xml) { read_xml('course/include_relation_search.xml') }
    let(:price) { course_list[0].price_list[4] }
    describe '#fare?' do
      it 'should return false' do
        expect(price.fare?).to be false
      end
    end
    describe '#charge?' do
      it 'should return false' do
        expect(price.charge?).to be false
      end
    end
    describe '#teiki?' do
      it 'should return false' do
        expect(price.teiki?).to be false
      end
    end
  end
  context '#kind == "Fare"' do
    let(:xml) { read_xml('course/include_relation_search.xml') }
    let(:price) { course_list[0].price_list[1] }
    describe '#fare?' do
      it 'should return true' do
        expect(price.fare?).to be true
      end
    end
    describe '#charge?' do
      it 'should return false' do
        expect(price.charge?).to be false
      end
    end
    describe '#teiki?' do
      it 'should return false' do
        expect(price.teiki?).to be false
      end
    end
  end
  context '#kind == "Charge"' do
    let(:xml) { read_xml('course/shinkansen_search.xml') }
    let(:price) { course_list[0].price_list[3] }
    describe '#fare?' do
      it 'should return false' do
        expect(price.fare?).to be false
      end
    end
    describe '#charge?' do
      it 'should return true' do
        expect(price.charge?).to be true
      end
    end
    describe '#teiki?' do
      it 'should return false' do
        expect(price.teiki?).to be false
      end
    end
  end
  context '#kind == "Teiki1"' do
    let(:xml) { read_xml('course/include_relation_search.xml') }
    let(:price) { course_list[0].price_list[5] }
    describe '#fare?' do
      it 'should return false' do
        expect(price.fare?).to be false
      end
    end
    describe '#charge?' do
      it 'should return false' do
        expect(price.charge?).to be false
      end
    end
    describe '#teiki?' do
      it 'should return true' do
        expect(price.teiki?).to be true
      end
    end
  end
end
