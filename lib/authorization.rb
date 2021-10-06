class CouponApp < Sinatra::Base
  def not_authorized
    halt 401
  end

  def authorized_request?
    token = ENV.fetch('API_KEY')
    request.env['HTTP_AUTHORIZATION'] == token
  end

  def forbidden
    ErrorSerializer.serialized_error(status: 401,
                                     source: 'coupon',
                                     details: 'You are not authorized. Check API key or contact administrator').to_json
  end
end
