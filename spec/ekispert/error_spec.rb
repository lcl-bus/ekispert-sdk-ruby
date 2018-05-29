require 'helper/ekispert/error_helper'

RSpec.describe Ekispert::Error do
  describe 'test raise_error' do
    let(:error) { Ekispert::Client .send(:raise_error, res) }
    let!(:stub_conn) do
      Faraday.new do |conn|
        conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('internalerror') do
            [1, {}, 'InternalError' ]
          end
          stub.get('badrequest') do
            [400, {}, 'BadRequest error' ]
          end
          stub.get('forbidden') do
            [403, {}, 'Forbidden error' ]
          end
          stub.get('clienterror') do
            [450, {}, 'ClientError' ]
          end
          stub.get('servererror') do
            [500, {}, 'ServerError' ]
          end
        end
      end
    end

    context '1 error' do
      let(:res) { stub_conn.get('internalerror') }
      it 'Ekispert::InternalError class' do
        expect { error }.to raise_error(Ekispert::InternalError)
      end
      it 'status 1' do
        expect(res.status).to eq 1
      end
      it 'InternalError body' do
        expect(res.body).to eq 'InternalError'
      end
    end
    context '400 error' do
      let(:res) { stub_conn.get('badrequest') }
      it 'Ekispert::BadRequest class' do
        expect { error }.to raise_error(Ekispert::BadRequest)
      end
      it 'status 400' do
        expect(res.status).to eq 400
      end
      it 'BadRequest body' do
        expect(res.body).to eq 'BadRequest error'
      end
    end
    context '403 error' do
      let(:res) { stub_conn.get('forbidden') }
      it 'Ekispert::Forbidden class' do
        expect { error }.to raise_error(Ekispert::Forbidden)
      end
      it 'status 403' do
        expect(res.status).to eq 403
      end
      it 'Forbidden body' do
        expect(res.body).to eq 'Forbidden error'
      end
    end
    context '450 error' do
      let(:res) { stub_conn.get('clienterror') }
      it 'Ekispert::ClientError class' do
        expect { error }.to raise_error(Ekispert::ClientError)
      end
      it 'status 450' do
        expect(res.status).to eq 450
      end
      it 'ClientError body' do
        expect(res.body).to eq 'ClientError'
      end
    end
    context '500 error' do
      let(:res) { stub_conn.get('servererror') }
      it 'Ekispert::ClientError class' do
        expect { error }.to raise_error(Ekispert::ServerError)
      end
      it 'status 500' do
        expect(res.status).to eq 500
      end
      it 'ServerError body' do
        expect(res.body).to eq 'ServerError'
      end
    end
  end
end
