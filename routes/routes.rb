class CouponApp < Sinatra::Base

  coupons = { id: 1, number: 5554777, discount: 20 }

  get '/coupons' do
    coupons.to_json
  end
end
