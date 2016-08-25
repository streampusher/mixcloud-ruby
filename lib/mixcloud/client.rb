require 'httmultiparty'

module Mixcloud
  class Client
    include HTTMultiParty
    API_URL = "https://api.mixcloud.com"
    headers({"Accept" => "application/json"})

    def initialize token
      @token = token
    end

    def upload file, name, picture
      result = self.class.post "#{authorized_url("upload")}", :query => {
        :mp3 => File.new(file),
        :name => name,
        :picture => File.new(picture)
      }
      JSON.parse(result.parsed_response)
    end

    private
    def authorized_url path
      "#{API_URL}/#{path}/?access_token=#{@token}"
    end
  end
end
