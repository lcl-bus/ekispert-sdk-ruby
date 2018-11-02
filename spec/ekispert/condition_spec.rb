require 'shared_condition'

RSpec.describe Ekispert::Condition do
  include Ekispert::SpecHelper::Config
  include_context 'shared Condition params'
  include_context 'shared Condition detail'

  describe '.get' do
    before { set_ekispert_default_config }
    let(:condition) { Ekispert::Condition.get }
    it 'should return Ekispert::Condition instance' do
      expect(condition.class).to eq Ekispert::Condition
    end
  end
  describe '.generate' do
    let(:params) { {} }
    let(:condition) { Ekispert::Condition.generate(params) }
    context 'default condition' do
      describe '#params' do
        it 'should return correct value' do
          expect(condition.params).to eq default_params
        end
      end
      describe '#text' do
        it 'should return correct value' do
          expect(condition.text).to eq default_detail
        end
      end
    end
  end
end
