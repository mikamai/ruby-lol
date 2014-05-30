module Lol
  class InvalidAPIResponse < StandardError
    attr_reader :raw

    def initialize url, response
      super "#{response["status"]["message"]} calling #{url}"
      @raw = raw
    end
  end
end