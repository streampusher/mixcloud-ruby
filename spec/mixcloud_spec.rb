require 'spec_helper'

describe Mixcloud do
  let(:token){ ENV['MIXCLOUD_TOKEN'] }
  it 'has a version number' do
    expect(Mixcloud::VERSION).not_to be nil
  end

  it 'uploads an mp3' do
    response = {"result"=>{"message"=>"Uploaded test", "key"=>"/datafruits/test/", "success"=>true}}
    VCR.use_cassette "mp3_upload" do
      expect(Mixcloud::Client.new(token).upload("spec/support/test.mp3", "test")).to eq response
    end
  end
end
