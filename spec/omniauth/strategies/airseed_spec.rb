require "spec_helper"

describe OmniAuth::Strategies::Airseed do
  subject do
    OmniAuth::Strategies::Airseed.new({})
  end

  context "client_options" do
    it "uses the correct site" do
      subject.options.client_options.site.should == "https://auth.airseed.com"
    end

    it "uses the correct authorize_url" do
      subject.options.client_options.authorize_url.
        should == "https://auth.airseed.com/oauth/authenticate"
    end

    it "uses the correct token_url" do
      subject.options.client_options.token_url.
        should == "https://auth.airseed.com/oauth/token"
    end
  end
end
