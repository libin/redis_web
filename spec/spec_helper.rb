ENV['RUBY_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', 'config', 'boot')
Sinatra::Application.environment = :test

RSpec.configure do |config|
  REDIS_PID = "#{AppConfig.root}/tmp/redis-test.pid"

  config.before(:each) do
    RedisAbstractor.redis.flushdb
  end

  config.before(:suite) do
    redis_options = {
      "daemonize"     => 'yes',
      "port"          => 6380,
      "timeout"       => 300,
      "databases"     => 1,
    }.map { |k, v| "#{k} #{v}" }.join('\n')
    `echo '#{redis_options}' | redis-server -`
  end

  config.after(:suite) do
    %x(redis-cli -p 6380 shutdown)
  end
end
