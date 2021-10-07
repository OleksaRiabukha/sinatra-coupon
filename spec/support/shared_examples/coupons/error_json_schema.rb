require 'spec_helper'

RSpec.shared_examples 'returns valid json object with errors' do
  it 'returns errors json object according to predefined schema' do
    expect(last_response).to match_response_schema('error')
  end
end
