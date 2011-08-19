class RedisWeb < Sinatra::Base
  configure do
    set :haml, :format => :html5
    set :views, File.join(APP_ROOT, 'app', 'views')
    set :root, APP_ROOT
    set :method_override, true
  end
end
