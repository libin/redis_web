class RedisWeb < Sinatra::Base
  get '/' do
    @redis_content = RedisAbstractor.get(RedisAbstractor.keys)
    if request.xhr?
      partial('redis_content', :locals => {:redis_content => @redis_content})
    else
      haml :index
    end
  end

  get '/search' do
    @redis_content = RedisAbstractor.get(RedisAbstractor.keys("*#{params[:q]}*"))
    if request.xhr?
      partial('redis_content', :locals => {:redis_content => @redis_content})
    else
      haml :index
    end
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
