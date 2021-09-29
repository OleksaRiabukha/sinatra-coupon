require 'spec_helper'

RSpec.describe CouponApp, type: :request do
  let(:header) { { 'Content-Type': 'application/json' } }

  describe 'POST /coupons' do
    context 'when user creates coupon with valid attributes' do
      let(:params) { { coupon: attributes_for(:coupon) }.to_json }

      before do
        post '/coupons', params, header
      end

      it 'returns a 200 code' do
        expect(last_response).to be_ok
      end

      it 'creates a coupon' do
        expect(Coupon.count).to eq(1)
      end

      it 'returns the coupon in predefined json schema' do
        expect(last_response).to match_response_schema('coupon')
      end

    end

    context 'when user create coupon with invalid attributes' do
      let(:params) { { coupon: { for_present: 'false' } } }

      before do
        post '/coupons', params.to_json, header
      end

      it 'returns a 422 code' do
        expect(last_response.status).to eq(422)
      end

      it 'does not add coupon to database' do
        expect(Coupon.count).to eq(0)
      end

      it 'returns an errors int predefined json schem' do
        expect(last_response).to match_response_schema('model_error')
      end
    end
  end

  describe 'PUT /coupons/:id' do
    context 'when user updates coupon with valid params' do
      let(:coupon) { create(:coupon, :with_coupon_number) }

      before do
        put "/coupons/#{coupon.coupon_number}"
      end

      it 'returns a 200 code' do
        expect(last_response).to be_ok
      end

      it "updates coupon's 'used' status" do
        used_coupon = JSON.parse(last_response.body).deep_symbolize_keys.dig(:data, :attributes, :used)
        expect(used_coupon).to eq(true)
      end

      it 'returns a coupon with predifined json scheme' do
        expect(last_response).to match_response_schema('coupon')
      end
    end

    context 'when user tries to update nonexistent coupon' do
      let(:nonexistent_coupon_number) { Faker::Alphanumeric.alphanumeric(number: 6) }

      before do
        put "/coupons/#{nonexistent_coupon_number}"
      end

      it 'returns a 400 code' do
        expect(last_response).to be_bad_request
      end

      it 'returns errors in predined json schema' do
        expect(last_response).to match_response_schema('custom_error')
      end
    end

   context 'when user tries to update already used coupon' do
     let(:used_coupon) { create(:coupon, :with_coupon_number, used: true) }

     before do
       put "/coupons/#{used_coupon.coupon_number}"
     end

     it 'returns a 400 code' do
       expect(last_response).to be_bad_request
     end

     it 'returns errors with predefined json schema' do
       expect(last_response).to match_response_schema('custom_error')
     end

     it 'notifies the coupon was previously used' do
       error_message = JSON.parse(last_response.body).deep_symbolize_keys[:errors][0][:detail]
       expect(error_message).to eq('Has already been used')
     end
   end
  end
end
