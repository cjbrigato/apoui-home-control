class Relay
  # include Jsonable
  attr_accessor :id, :name, :localname, :fimage, :description, :place, :masterip

  #@@salt = 'rYeGvzOG2Df0gpq8'
  #
  #def api_key_generate
  #  apizable = @username + @cipher + @@salt
  #  Digest::SHA256.new.hexdigest(apizable)
  #end
  #
  #alias api_key api_key_generate
  #
  #def self.salt
  #  @@salt
  #end

  def to_json(*a)
    result = {}
    # result['json_class'] = self.class.name
    instance_variables.each do |var|
      result[var.to_s.delete '@'] = instance_variable_get var
    end
    result.to_json(*a)
    end
end

$relays = YAML.load_file('./db/relays.yml')
