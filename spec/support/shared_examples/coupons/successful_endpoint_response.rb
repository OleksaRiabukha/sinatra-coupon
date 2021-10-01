require 'spec_helper'

RSpec.shared_examples "returns an 'ok' status code" do
  it 'returns a 200 code' do
    expect(last_response).to be_ok
  end
end
