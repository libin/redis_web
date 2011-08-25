class RedisWeb < Sinatra::Base
  get '/' do
    if request.xhr?
      RedisAbstractor.get(RedisAbstractor.keys).to_json
    else
      haml :index
    end
  end

  get '/search' do
    if request.xhr?
      RedisAbstractor.get(RedisAbstractor.keys("*#{params[:q]}*")).to_json
    else
      haml :index
    end
  end

  get '/redis/:key' do
    RedisAbstractor.get_value(params[:key]).to_json
  end

  put '/redis' do
    AppConfig::Redis.options.merge!({:db => params[:db]})
    AppConfig::Redis.refresh
    redirect_back
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
