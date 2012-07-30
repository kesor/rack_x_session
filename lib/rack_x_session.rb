require 'rack'

module Rack
  class XSession
    attr_reader :store
    def initialize(app, kwargs={})
      header_name = kwargs.delete(:header_name) || 'X-Session'
      store_class = kwargs.delete(:store_class) || Hash

      @app = app
      @env_key = "HTTP_#{header_name}".upcase.tr('-', '_')
      @store = store_class.new
    end
    def call(env)
      env['rack.session'] = env[@env_key]
      @app.call(env)
    end
  end
end
