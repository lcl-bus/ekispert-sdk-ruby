require 'helper/ekispert/error_helper'

RSpec.describe Ekispert::ClientError do
  describe '.raise_error' do
    let(:error) { Ekispert::Client .send(:raise_error, Ekispert::SpecHelper::ClientError.res_error(error_code)) }
    context '1 error' do
      let(:error_code) { 1 }
      it 'Ekispert::InternalError class' do
        expect{ error }.to raise_error(Ekispert::InternalError)
      end
    end
    context '400 error' do
      let(:error_code) { 400 }
      it 'Ekispert::BadRequest class' do
        expect{ error }.to raise_error(Ekispert::BadRequest)
      end
    end
    context '403 error' do
      let(:error_code) { 403 }
      it 'Ekispert::Forbidden class' do
        expect{ error }.to raise_error(Ekispert::Forbidden)
      end
    end
    context '450 error' do
      let(:error_code) { 450 }
      it 'Ekispert::ClientError class' do
        expect{ error }.to raise_error(Ekispert::ClientError)
      end
    end
    context '500 error' do
      let(:error_code) { 500 }
      it 'Ekispert::ServerError class' do
        expect{ error }.to raise_error(Ekispert::ServerError)
      end
    end
  end
end
