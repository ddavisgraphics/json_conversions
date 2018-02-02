require 'json_conversions/version'
require 'json'

module JsonConversions
  # Validate JSON
  class Validate
    def self.valid?(json)
      !!JSON.parse(json) rescue false
    end
  end

  # class Html 
  #   def initialize(json)
  #     @json = json 
  #   end
  # end
end
