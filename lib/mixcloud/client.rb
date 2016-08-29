require 'httmultiparty'

module Mixcloud
  class Client
    include HTTMultiParty
    default_timeout 600
    API_URL = "https://api.mixcloud.com"
    headers({"Accept" => "application/json"})

    def initialize token
      @token = token
    end

    def upload file, name, picture=nil
      params = {
        :mp3 => File.new(file),
        :name => name,
      }
      if picture
        params[:picture] = File.new(picture)
      end
      result = self.class.post "#{authorized_url("upload")}", :query => params
      JSON.parse(result.parsed_response)
    end

    private
    def authorized_url path
      "#{API_URL}/#{path}/?access_token=#{@token}"
    end
  end
end
