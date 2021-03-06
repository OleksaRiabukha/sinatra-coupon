class CouponApp < Sinatra::Base

  before do
    content_type 'application/json'
    not_authorized unless authorized_request?
  end

  post '/coupons' do

    coupon_json_params
    coupon = Coupon.new(amount: @coupon_attributes[:amount], for_present: @coupon_attributes[:for_present])

    if coupon.save
      CouponSerializer.new(coupon).serializable_hash.to_json
    else
      status 422
      ErrorSerializer.serialized_error(status: 422, model: coupon).to_json
    end
  end

  put '/coupons/:coupon_number' do

    coupon = find_coupon

    if coupon.nil?
      status 400
      ErrorSerializer.serialized_error(status: 400,
                                       source: 'coupon',
                                       details: 'No such coupon').to_json
    elsif coupon.used?
      status 400
      ErrorSerializer.serialized_error(status: 400,
                                       source: 'coupon',
                                       details: 'Has already been used').to_json
    else
      coupon.use_coupon
      CouponSerializer.new(coupon).serializable_hash.to_json
    end
  end

  private

  def find_coupon
    Coupon.find_by(coupon_number: params[:coupon_number])
  end

  def coupon_json_params
    @coupon_attributes = {}
    params_hash = JSON.parse(request.env['rack.input'].read).deep_symbolize_keys
    params_hash.each do |_key, value|
      value.each do |params_key, params_value|
        @coupon_attributes[params_key] = params_value
      end
    end
  end
end
