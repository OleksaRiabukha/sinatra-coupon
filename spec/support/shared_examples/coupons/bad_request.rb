require 'spec_helper'

RSpec.shared_examples 'returns bad request status' do
  it 'returns a 400 code' do
    expect(last_response).to be_bad_request
  end
end
