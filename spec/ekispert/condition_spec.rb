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
    context 'params not include :detail' do
      context 'custom traffic' do
        let(:params) { custom_traffic_params }
        describe '#params' do
          it 'should return correct value' do
            expect(condition.params).to eq default_params.merge(custom_traffic_params)
          end
        end
        describe '#text' do
          it 'should return correct value' do
            expect(condition.text).to eq "#{custom_traffic_detail}#{default_fee_detail}#{default_adjunctive_detail}"
          end
        end
      end
      context 'custom fee' do
        let(:params) { custom_fee_params }
        describe '#params' do
          it 'should return correct value' do
            expect(condition.params).to eq default_params.merge(custom_fee_params)
          end
        end
        describe '#text' do
          it 'should return correct value' do
            expect(condition.text).to eq "#{default_traffic_detail}#{custom_fee_detail}#{default_adjunctive_detail}"
          end
        end
        context 'jr_reservation: "exYoyaku"' do
          let(:params) { custom_fee_params.merge(jr_reservation: 'exYoyaku') }
          describe '#params' do
            it 'should return correct value' do
              expect(condition.params[:jr_reservation]).to eq 'exYoyaku'
            end
          end
          describe '#text' do
            it 'should return correct value' do
              expect(condition.text.split(':')[1][11..12]).to eq '10'
            end
          end
        end
        context 'jr_reservation: "smartExHayatoku"' do
          let(:params) { custom_fee_params.merge(jr_reservation: 'smartExHayatoku') }
          describe '#params' do
            it 'should return correct value' do
              expect(condition.params[:jr_reservation]).to eq 'smartExHayatoku'
            end
          end
          describe '#text' do
            it 'should return correct value' do
              expect(condition.text.split(':')[1][11..12]).to eq '02'
            end
          end
        end
        context 'jr_reservation: "exYoyaku" and "smartExHayatoku"' do
          let(:params) { custom_fee_params.merge(jr_reservation: 'exYoyaku', jr_reservation: 'smartExHayatoku') }
          describe '#params' do
            it 'should return correct value' do
              expect(condition.params[:jr_reservation]).to eq 'smartExHayatoku'
            end
          end
          describe '#text' do
            it 'should return correct value' do
              expect(condition.text.split(':')[1][11..12]).to eq '02'
            end
          end
        end
      end
      context 'custom adjunctive' do
        let(:params) { custom_adjunctive_params }
        describe '#params' do
          it 'should return correct value' do
            expect(condition.params).to eq default_params.merge(custom_adjunctive_params)
          end
        end
        describe '#text' do
          it 'should return correct value' do
            expect(condition.text).to eq "#{default_traffic_detail}#{default_fee_detail}#{custom_adjunctive_detail}"
          end
        end
      end
      context 'camelcase params' do
        let(:params) { camelcase_params }
        describe '#params' do
          it 'should return correct value' do
            expect(condition.params).to eq custom_params
          end
        end
        describe '#text' do
          it 'should return correct value' do
            expect(condition.text).to eq custom_detail
          end
        end
      end
    end
    context 'params include :detail' do
      context 'not include condition params (only :detail)' do
        let(:params) { { detail: custom_detail } }
        describe '#params' do
          it 'should return correct value' do
            expect(condition.params).to eq custom_params
          end
        end
        describe '#text' do
          it 'should return correct value' do
            expect(condition.text).to eq custom_detail
          end
        end
      end
      context 'include condition params' do
        let(:params) { default_traffic_params.merge(detail: custom_detail) }
        describe '#params' do
          it 'should return correct value' do
            expect(condition.params).to eq custom_params.merge(default_traffic_params)
          end
        end
        describe '#text' do
          it 'should return correct value' do
            expect(condition.text).to eq "#{default_traffic_detail}#{custom_fee_detail}#{custom_adjunctive_detail}"
          end
        end
      end
    end
  end
  describe '#update' do
    let(:condition) { Ekispert::Condition.generate(detail: custom_detail) }
    context 'default traffic' do
      let(:update_condition) { condition.update(default_traffic_params) }
      describe '#params' do
        it 'should return correct value' do
          expect(update_condition.params).to eq custom_params.merge(default_traffic_params)
        end
      end
      describe '#text' do
        it 'should return correct value' do
          expect(update_condition.text).to eq "#{default_traffic_detail}#{custom_fee_detail}#{custom_adjunctive_detail}"
        end
      end
    end
  end
end
