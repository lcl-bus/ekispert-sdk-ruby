require 'spec_helper'

RSpec.describe Ekispert::Information do
  include Ekispert::SpecHelper::Config
  describe '.get' do
    before { set_ekispert_default_config }
    context 'params = { code: 22828, type: "rail" }' do
      let(:information_list) { Ekispert::Information.get(code: 22828, type: 'rail') }
      it 'return Array contain Ekispert::Information instance' do
        expect(information_list[0].class).to eq Ekispert::Information
      end
      describe 'Ekispert::Information#type' do
        it 'should return "rail"' do
          expect(information_list[0].type).to eq 'rail'
        end
      end
    end
  end
  describe '.to_information_class' do
  end
end
