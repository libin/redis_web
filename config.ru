require File.dirname(__FILE__) + '/config/boot'

require './app/redis_web'
run RedisWeb
