require "spec_helper"

describe JsonConversions do
  it 'has a version number' do
    expect(JsonConversions::VERSION).not_to be nil
  end

  it 'validates a valid json string, also returns a hash' do
    test_json = '{"id": 1, "first_name": "Berry", "last_name": "Brealey"}'
    type = JsonConversions::Handler.valid(test_json).class
    expect(JsonConversions::Handler.valid(test_json)).to be_truthy
    expect(type).to eq(Hash)
  end

  it 'tests if json string is invalid and throws an exception' do
    test_json = '{"id": 1 "firstname": "Berry"}'
    expect { JsonConversions::Handler.valid(test_json) }.to raise_error(/Error: wrong filetype or invalid json/)
  end

  it 'takes a valid json file and returns the result if valid' do
    test_json = './spec/files/valid.json'
    type = JsonConversions::Handler.valid(test_json).class
    expect(JsonConversions::Handler.valid(test_json)).to be_truthy
    expect(type).to eq(Hash)
  end

  it 'tests invalid json file and raises an exception' do
    test_json = './spec/files/invalid.json'
    expect { JsonConversions::Handler.valid(test_json) }.to raise_error(/Error: wrong filetype or invalid json/)
  end

  it 'turns key value pairs into simple html' do
    key = 'somekey'
    value = 'Some Value'
    return_html = "<div class='#{key}'> <strong> #{key.capitalize} </strong> #{value} </div>"
    expect(JsonConversions::Html.markup(key, value)).to eq(return_html)
  end

end
