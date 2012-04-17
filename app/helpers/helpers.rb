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

    def format_code(value)
      if value.respond_to?(:each)
        values = value.map { |item| json_pretty_print(item) }.join(",\n")
        "[#{values}]"
      else
        json_pretty_print(value)
      end
    end

    def json_pretty_print(json)
      JSON.pretty_generate(JSON.parse(json)) rescue json
    end

    def redirect_back
      redirect request.referrer || '/'
    end

    def partial(page, options={})
      haml page.to_sym, options.merge!(:layout => false)
    end

    def database_description(db_name, meta)
      name = "db#{db_name}"
      name << " (#{meta})" if meta
      name
    end
  end
end
