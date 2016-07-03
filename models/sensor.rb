#- !ruby/object:sensor
#  id: 2
#  name: chambre.temp.sensor1
#  localname: sensor1
#  type: temperature
#  description: Temperature Chambre
#  place: Chambre - Table de nuit Colin
#  masterip: 192.168.1.16
class Sensor
  # include Jsonable
  attr_accessor :id, :name, :localname, :type, :description, :place, :masterip

  def to_json(*a)
    result = {}
    # result['json_class'] = self.class.name
    instance_variables.each do |var|
      result[var.to_s.delete '@'] = instance_variable_get var
    end
    result.to_json(*a)
  end
end

$sensors = YAML.load_file('./db/sensors.yml')
