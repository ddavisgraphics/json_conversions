require 'json_conversions/version'
require 'json'

module JsonConversions
  # Validate JSON
  class Handler
    attr_accessor :json
    def self.valid(json)
      begin
        if json.end_with? '.json'
          file = File.read(json)
          @json = JSON.parse(file)
        else
          @json = JSON.parse(json)
        end
      rescue JSON::ParserError => e
        raise StandardError, 'Error: wrong filetype or invalid json ' + e.message
      end
    end
  end

  class Html
    attr_accessor :json
    def initialize(json)
      @json = JSON.parse(json)
    end

    def self.markup(key,value)
      "<div class='#{key}'> <strong> #{key.capitalize} </strong> #{value} </div>"
    end
  end
end
