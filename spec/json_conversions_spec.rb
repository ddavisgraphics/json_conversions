require "spec_helper"

describe JsonConversions do
  it 'has a version number' do
    expect(JsonConversions::VERSION).not_to be nil
  end

  it 'validates a valid json string, also returns a hash' do
    test_json = '{"id": 1, "first_name": "Berry", "last_name": "Brealey"}'
    handler = JsonConversions::Handler.new(test_json)
    type = handler.valid.class
    expect(handler.valid).to be_truthy
    expect(type).to eq(Hash)
  end

  it 'tests if json string is invalid and throws an exception' do
    test_json = '{"id": 1 "firstname": "Berry"}'
    handler = JsonConversions::Handler.new(test_json) 
    expect { handler.valid }.to raise_error(/Error: wrong filetype or invalid json/)
  end

  it 'takes a valid json file and returns the result if valid' do
    test_json = './spec/files/valid.json'
    handler = JsonConversions::Handler.new(test_json)
    type = handler.valid.class
    expect(handler.valid).to be_truthy
    expect(type).to eq(Hash)
  end

  it 'tests invalid json file and raises an exception' do
    test_json = './spec/files/invalid.json'
    handler = JsonConversions::Handler.new(test_json)
    expect { handler.valid }.to raise_error(/Error: wrong filetype or invalid json/)
  end

  it 'allows for getting the valid json from the handler method' do
    json = './spec/files/valid.json' 
    handler = JsonConversions::Handler.new(json)
    valid_json = handler.valid
    accessor_json = handler.json
    expect(valid_json).to eq(accessor_json)
  end

  it 'allows for getting the raw json value back that was fed upon instantiation' do
    json = './spec/files/valid.json'
    handler = JsonConversions::Handler.new(json)
    expect(json).to eq(handler.raw_json)
  end

  it 'sets raw json seperatly' do
    json = './spec/files/valid.json'
    new_json = './spec/files/large_valid.json'
    handler = JsonConversions::Handler.new(json)
    handler.raw_json = new_json
    expect(handler.raw_json).to eq(new_json)
  end

  it 'validate raw json after setting it manually' do
    test_json = './spec/files/valid.json'
    new_json = './spec/files/large_valid.json'
    new_test_json = JSON.parse(File.read(new_json))
    handler = JsonConversions::Handler.new(test_json)
    handler.raw_json = new_json
    json = handler.valid
    expect(json).to be_truthy
    expect(json).to eq(new_test_json)
  end

  it '' do
  
  end 

  it 'turns key value pairs into simple html' do
    key = 'somekey'
    value = 'Some Value'
    return_html = "<div class='#{key}'> <strong> #{key.capitalize} </strong> #{value} </div>"
    expect(JsonConversions::Html.markup(key, value)).to eq(return_html)
  end
end
