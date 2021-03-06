require 'spec_helper'

describe Mixcloud do
  let(:token){ ENV['MIXCLOUD_TOKEN'] }
  it 'has a version number' do
    expect(Mixcloud::VERSION).not_to be nil
  end

  it 'uploads an mp3' do
    expected_response = {"result"=>{"message"=>"Uploaded test", "key"=>"/freedrool/test/", "success"=>true}}
    VCR.use_cassette(RSpec.current_example.metadata[:full_description].to_s) do
      actual_response = Mixcloud::Client.new(token).upload("spec/support/test.mp3", "test", "spec/support/artwork2.png")
      expect(actual_response).to eq expected_response
    end
  end

  it 'artwork is optional' do
    expected_response = {"result"=>{"message"=>"Uploaded test", "key"=>"/freedrool/test-1/", "success"=>true}}
    VCR.use_cassette(RSpec.current_example.metadata[:full_description].to_s) do
      actual_response = Mixcloud::Client.new(token).upload("spec/support/test.mp3", "test")
      expect(actual_response).to eq expected_response
    end
  end

  it 'sends tags' do
    expected_response = {"result"=>{"message"=>"Uploaded test", "key"=>"/freedrool/test/", "success"=>true}}
    VCR.use_cassette(RSpec.current_example.metadata[:full_description].to_s) do
      actual_response = Mixcloud::Client.new(token).upload("spec/support/test.mp3", "test", nil, ["grime", "funky"])
      expect(actual_response).to eq expected_response
    end
  end
end
