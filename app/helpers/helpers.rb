class RedisWeb < Sinatra::Base
  helpers do
    def link_to(url, text, link_class = nil, title=nil)
      "<a href=#{url} class=#{link_class} title=#{title}>#{text}</a>"
    end

    def image_tag(image_path)
      "<img src='/images/#{image_path}' />"
    end

    def delete_key_path(key)
      "/redis/#{key}"
    end

    def redirect_back
      redirect request.referrer || '/'
    end

    def partial(page, options={})
      haml page.to_sym, options.merge!(:layout => false)
    end
  end
end
