require 'rack'

module Rack
  class XSession
    def initialize(app, header_name='X-Session')
      @app = app
      @env_key = "HTTP_#{header_name}".upcase.tr('-', '_')
    end
    def call(env)
      env[@env_key] = 'session data'
      @app.call(env)
    end
  end
end
