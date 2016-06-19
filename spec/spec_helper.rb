$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mixcloud'
require 'vcr'
require 'dotenv'
Dotenv.load

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb

  config.filter_sensitive_data("<CLIENT_ID>") do
    ENV.fetch 'CLIENT_ID', "x"*40
  end

  config.filter_sensitive_data("<CLIENT_SECRET>") do
    ENV.fetch 'CLIENT_SECRET', "x"*40
  end

  config.filter_sensitive_data("<MIXCLOUD_TOKEN>") do
    ENV.fetch "MIXCLOUD_TOKEN", "x"*40
  end
end
