require File.join(File.dirname(__FILE__), '..', 'config', 'boot')
Sinatra::Application.environment = :test

RSpec.configure do |config|
  REDIS_PID = "#{AppConfig.root}/tmp/redis-test.pid"

  config.before(:each) do
    RedisAbstractor.redis.keys.each{|k| RedisAbstractor.redis.del(k)}
  end

  config.before(:suite) do
    redis_options = {
      "daemonize"     => 'yes',
      "pidfile"       => REDIS_PID,
      "port"          => 6379,
      "timeout"       => 300,
      "dbfilename"    => "dump.rdb",
      "loglevel"      => "debug",
      "logfile"       => "stdout",
      "databases"     => 16
    }.map { |k, v| "#{k} #{v}" }.join('\n')
    `echo '#{redis_options}' | redis-server -`
  end

  config.after(:suite) do
    if File.exist? REDIS_PID
      pid = File.read(REDIS_PID)
      %x(kill #{pid})
      FileUtils.rm_f(REDIS_PID)
    end
  end
end
