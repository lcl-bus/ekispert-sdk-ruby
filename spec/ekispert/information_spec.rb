RSpec.describe Ekispert::Information do
  include Ekispert::SpecHelper::Config
  describe '.get' do
    before { set_ekispert_default_config }
    context 'use stationcode Tokyo & type rail）' do
      let(:information) { Ekispert::Information.get(22828,'rail') }
      it 'return Ekispert::Information class' do
        expect(information.class).to eq Ekispert::Information
      end
      it 'create line_list' do
        expect(information.line_list).not_to be nil
      end
      it 'create corporition_list' do
        expect(information.corporation_list.class).not_to be nil
      end
      it 'createdlist class is Array' do
        expect(information.line_list.class).to eq Array
      end

      it 'Ekispert::Information::Line instance in line_list' do
        expect(information.line_list[0].class).to eq Ekispert::Information::Line
      end
    end
    context 'error' do
      it 'error' do
      end
    end
  end
end
