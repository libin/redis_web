class RedisWeb < Sinatra::Base
  get '/' do
    @redis_content = RedisAbstractor.get(RedisAbstractor.keys)
    haml :"index"
  end

  delete '/redis/:key' do
    content_type :json
    RedisAbstractor.del(params[:key])
  end

  get '/stylesheets/*.css' do
    scss :"/sass/#{params[:splat].first}"
  end

  get '/javascripts/*.js' do
    coffee :"/coffee/#{params[:splat].first}"
  end
end
