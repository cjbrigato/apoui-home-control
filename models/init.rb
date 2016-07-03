#require 'sequel'
#DB = Sequel.sqlite('./db/rescue.db')
#Sequel::Model.plugin :json_serializer
# Sequel::Model.strict_param_setting = false

#require_relative 'server'
#require_relative 'subnet'
require_relative 'relay'
require_relative 'sensor'
