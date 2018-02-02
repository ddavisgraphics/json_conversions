require "spec_helper"

describe JsonConversions do
  it "has a version number" do
    expect(JsonConversions::VERSION).not_to be nil
  end

  it 'validates a valid json string' do
    test_json = '{"id": 1, "first_name": "Berry", "last_name": "Brealey"}'
    expect(JsonConversions::Validate.valid?(test_json)).to eq(true)
  end

  it 'returns false if json string is not valid' do
    test_json = '{"id": 1 "firstname": "Berry"}'
    expect(JsonConversions::Validate.valid?(test_json)).to eq(false)
  end
end
