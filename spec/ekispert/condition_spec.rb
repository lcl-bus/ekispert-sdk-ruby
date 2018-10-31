RSpec.describe Ekispert::Condition do
  include Ekispert::SpecHelper::Config

  describe '.get' do
    before { set_ekispert_default_config }
    let(:condition) { Ekispert::Condition.get }
    it 'should return Ekispert::Condition instance' do
      expect(condition.class).to eq Ekispert::Condition
    end
  end
end
