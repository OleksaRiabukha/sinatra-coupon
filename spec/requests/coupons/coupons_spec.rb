require 'spec_helper'

RSpec.describe CouponApp, type: :request do
  let(:api_key) { ENV.fetch('API_KEY') }

  context 'when user requests with valid API token' do
    describe 'POST /coupons' do
      context 'when user creates coupon with valid attributes' do
        let(:params) { { coupon: attributes_for(:coupon) }.to_json }

        before do
          env 'HTTP_AUTHORIZATION', api_key
          post '/coupons', params
        end

        it 'creates a coupon' do
          expect(Coupon.count).to eq(1)
        end

        include_examples "returns an 'ok' status code"

        include_examples 'returns valid json object'
      end

      context 'when user create coupon with invalid attributes' do
        let(:params) { { coupon: { for_present: 'false' } } }

        before do
          env 'HTTP_AUTHORIZATION', api_key
          post '/coupons', params.to_json
        end

        it 'returns a 422 code' do
          expect(last_response.status).to eq(422)
        end

        it 'does not add coupon to database' do
          expect(Coupon.count).to eq(0)
        end

        include_examples 'returns valid json object with errors'
      end
    end

    describe 'PUT /coupons/:id' do
      context 'when user updates coupon with valid params' do
        let(:coupon) { create(:coupon) }

        before do
          env 'HTTP_AUTHORIZATION', api_key
          put "/coupons/#{coupon.coupon_number}"
        end

        it "updates coupon's 'used' status" do
          used_coupon = JSON.parse(last_response.body).deep_symbolize_keys.dig(:data, :attributes, :used)
          expect(used_coupon).to eq(true)
        end

        include_examples "returns an 'ok' status code"

        include_examples 'returns valid json object'
      end

      context 'invalid requests' do
        let(:nonexistent_coupon_number) { Faker::Alphanumeric.alphanumeric(number: 6) }
        let(:used_coupon) { create(:coupon, used: true) }

        before do
          env 'HTTP_AUTHORIZATION', api_key
          put "/coupons/#{nonexistent_coupon_number}"
        end

        include_examples 'returns bad request status'

        include_examples 'returns valid json object with errors'

        it 'notifies the coupon was previously used if users tries to reuse coupon' do
          put "/coupons/#{used_coupon.coupon_number}"
          error_message = JSON.parse(last_response.body).deep_symbolize_keys[:errors][0][:details]
          expect(error_message).to eq('Has already been used')
        end
      end
    end
  end
  context 'when user requests with invalid or missing token' do
    describe 'POST coupons' do
      let(:params) { { coupon: attributes_for(:coupon) }.to_json }

      before do
        post '/coupons', params
      end

      it 'returns 401 code' do
        expect(last_response).to be_unauthorized
      end

      it 'does not add coupon to database' do
        expect(Coupon.count).to eq(0)
      end

      it 'asks user to check api key or contact admin' do
        error_message = JSON.parse(last_response.body).deep_symbolize_keys[:errors][0][:details]
        expect(error_message).to eq('You are not authorized. Check API key or contact administrator')
      end

    end
  end
end
