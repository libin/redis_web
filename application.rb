configure do
  set :haml, :format => :html5
  set :root, File.dirname(__FILE__)
end

helpers do
  def link_to(url, text, link_class = nil, title=nil)
    "<a href=#{url} class=#{link_class} title=#{title}>#{text}</a>"
  end

  def delete_key_path(key)
    "/redis/delete/#{key}"
  end

  def redirect_back
    redirect request.referrer || '/'
  end

  def partial(page, options={})
    haml page.to_sym, options.merge!(:layout => false)
  end
end

get '/' do
  @redis_content = RedisAbstractor.get(RedisAbstractor.keys)
  haml :"index"
end

delete '/redis/delete/:key' do
  RedisAbstractor.del(params[:key])
  redirect_back
end

get '/stylesheets/*.css' do
  scss :"/sass/#{params[:splat].first}"
end

get '/javascripts/*.js' do
  coffee :"/coffee/#{params[:splat].first}"
end
