require 'spec_helper'
require 'helper/ekispert/error_helper'

RSpec.describe Ekispert::Client do
  include Ekispert::SpecHelper::Error
  describe '.raise_error' do
    let(:error) { Ekispert::Client.send(:raise_error, res) }
    let(:res_data) { Ekispert::ClientError.new(res) }
    let(:stub_conn) { Faraday::Adapter::Test::Stubs.new }

    context '001 error' do
      let(:res) { test_faraday.get('/internalerror') }
      it 'Ekispert::InternalError class' do
        expect { error }.to raise_error(Ekispert::Error::InternalError)
      end
      it 'status 001' do
        expect(res.status).to eq 1
      end
      it 'correct url' do
        expect(res.env.url.to_s).to eq 'http:/internalerror'
      end
    end

    context '400 error' do
      let(:res) { test_faraday.get('/badrequest') }
      it 'Ekispert::BadRequest class' do
        expect { error }.to raise_error(Ekispert::Error::BadRequest)
      end
      it 'status 400' do
        expect(res.status).to eq 400
      end
      it 'correct url' do
        expect(res.env.url.to_s).to eq 'http:/badrequest'
      end
    end

    context '400 errors' do
      let(:res) { test_faraday.get('/raiseerrors') }
      it 'Ekispert::BadRequest class' do
        expect { error }.to raise_error(Ekispert::Error::BadRequest)
      end
      it 'status 400' do
        expect(res.status).to eq 400
      end
      it 'correct url' do
        expect(res.env.url.to_s).to eq 'http:/raiseerrors'
      end
    end

    context '403 error' do
      let(:res) { test_faraday.get('/forbidden') }
      it 'Ekispert::Forbidden class' do
        expect { error }.to raise_error(Ekispert::Error::Forbidden)
      end
      it 'status 403' do
        expect(res.status).to eq 403
      end
      it 'correct url' do
        expect(res.env.url.to_s).to eq 'http:/forbidden'
      end
    end

    context '450 error' do
      let(:res) { test_faraday.get('/clienterror') }
      it 'Ekispert::ClientError class' do
        expect { error }.to raise_error(Ekispert::Error::ClientError)
      end
      it 'status 450' do
        expect(res.status).to eq 450
      end
      it 'correct url' do
        expect(res.env.url.to_s).to eq 'http:/clienterror'
      end
    end

    context '500 error' do
      let(:res) { test_faraday.get('/servererror') }
      it 'Ekispert::ServerError class' do
        expect { error }.to raise_error(Ekispert::Error::ServerError)
      end
      it 'status 500' do
        expect(res.status).to eq 500
      end
      it 'correct url' do
        expect(res.env.url.to_s).to eq 'http:/servererror'
      end
    end
  end
end
