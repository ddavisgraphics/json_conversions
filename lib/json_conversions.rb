require 'json_conversions/version'
require 'json'

# Namespace for classes and that handle json conversions
# @since 0.1.0
module JsonConversions
  # Handler class parses the json and preps it for next stages based on given arguments
  #
  # @author David J. Davis
  # @since 0.1.0
  # @attr_accessor :json the parsed json that was sent into the document 
  # @attr_accessor :raw_json the string or file given when the handler class was instantied 
  class Handler
    attr_accessor :json, :raw_json

    # Sets raw json on instantiation no return value 
    #
    # @author David J. Davis
    def initialize(json)
      @raw_json = json
    end

    # The method that validates json and sets up for the next step in parsing the document.
    # Failure will result in a system error being thrown. 
    #
    # @author David J. Davis
    #
    # @return [Hash] is the hash of the json contents
    def valid
      begin
        if @raw_json.end_with? '.json'
          file = File.read(@raw_json)
          @json = JSON.parse(file)
        else
          @json = JSON.parse(@raw_json)
        end
      rescue JSON::ParserError => e
        raise StandardError, 'Error: wrong filetype or invalid json ' + e.message
      end
    end

    def conversion(type)
      puts "Type of conversion #{type}"
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
