#env_vars_file = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'etc', 'common', 'env_vars')
#File.readlines(env_vars_file).each do |line|
#  line.chomp!
#  key, value = line.split '='
#  ENV[key] = value
#end

require 'ipaddr'
require 'yaml'
require 'jsonable'

require 'sinatra/base'
require 'sinatra/session'
require 'sinatra/namespace'
require 'sinatra/multi_route'
# require "sinatra/json"

require_relative 'controllers/init'
require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'
