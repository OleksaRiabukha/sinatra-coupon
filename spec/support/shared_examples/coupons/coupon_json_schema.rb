require 'spec_helper'

RSpec.shared_examples 'returns valid json object' do
  it 'returns the coupon json object according to predefined schema' do
    expect(last_response).to match_response_schema('coupon')
  end
end
