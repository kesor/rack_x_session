require 'spec_helper'

describe Rack::XSession do

  let(:app) do
    Rack::Builder.new do
      run lambda { |env| [200, {}, "OK"] }
    end
  end

  it "reads session from X-Session header" do
    app.use Rack::XSession
    get "/"
    last_request.env.keys.should include('HTTP_X_SESSION')
    last_request.env['HTTP_X_SESSION'].should == 'session data'
  end

  it "can use other headers for storage" do
    app.use Rack::XSession, 'X-Alternative'
    get "/"
    last_request.env.keys.should include('HTTP_X_ALTERNATIVE')
    last_request.env['HTTP_X_ALTERNATIVE'].should == 'session data'
  end

  it "uses modular storage for session" do
    pending
    # middleware passes just handles the read of header
    # another module used to actually store/fetch the data
  end

  it "works with a session id in the header" do
    pending
    # X-Session header contains just the ID of a session
    # and the session data is loaded via a proc that gets it
    # from "somewhere"
  end

  it "works with full session data in the header" do
    pending
    # X-Session header contains encoded session data
    # this is also the default
  end

end
