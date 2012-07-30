require 'spec_helper'

describe Rack::XSession do

  let(:app) do
    Rack::Builder.new do
      run lambda { |env| [200, {}, "OK"] }
    end
  end

  context "header naming" do
    it "reads session id from X-Session header" do
      app.use Rack::XSession
      header "X-Session", "some-session-id"
      get "/"
      last_request.env['rack.session'].should == "some-session-id"
    end
    it "allows to use alternative headers" do
      app.use Rack::XSession, { header_name: 'X-Alternative' }
      header 'X-Alternative', "another-session-id"
      get "/"
      last_request.env['rack.session'].should == "another-session-id"
    end
  end

  context "session stores" do
    it "uses Hash as default session store" do
      Rack::XSession.new(app).store.should be_kind_of Hash
    end
  end

end
