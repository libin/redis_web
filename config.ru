require File.dirname(__FILE__) + '/config/boot'

require './application'
run Sinatra::Application
