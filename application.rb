configure do
  set :haml, :format => :html5
  set :root, File.dirname(__FILE__)
end

helpers do
end

get '/' do
  redis_reader = RedisReader.new
  @redis_dump = redis_reader.dump
  haml :"index"
end

get '/stylesheets/*.css' do
  scss :"/sass/#{params[:splat].first}"
end

get '/javascripts/*.js' do
  coffee :"/coffee/#{params[:splat].first}"
end
