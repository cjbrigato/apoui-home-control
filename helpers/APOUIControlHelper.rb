module APOUIControlHelper

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

  def title(value = nil)
    @title = value if value
    @title ? "Briganious- APOUI HOME CONTROL #{@title}" : 'APOUI!'
  end

  def getrelaystatus(relay)
      @rid = relay.to_i
      @srelay = $relays.select { |relay| relay.id == @rid }
      @srelay.each do |relay|
        @lrelay = relay
      end
      @status = `curl --connect-timeout 0.2 http://#{@lrelay.masterip}/#{@lrelay.localname}/status`
      #if !(@status == "ON" ||  @status == "OFF") then @status = "OUT OF SERVICE"
      @status = "UNAVAILABLE" unless @status  =~ /\A(?:OFF|ON)\z/
      return @status
  end

  def getsensorvalue(sensor)
      @sid = sensor.to_i
      @ssensor = $sensors.select { |sensor| sensor.id == @sid }
      @ssensor.each do |sensor|
        @lsensor = sensor
      end
      if (@lsensor.type == "temperature")
        @value = `curl --connect-timeout 0.2 http://#{@lsensor.masterip}/temperature|cut -d";" -f2`
      elsif (@lsensor.type == "humidity")
        @value = `curl --connect-timeout 0.2 http://#{@lsensor.masterip}/humidity|cut -d";" -f2`
      elsif (@lsensor.type == "doorlock")
        @value = `curl --connect-timeout 0.2 http://#{@lsensor.masterip}/status|cut -d";" -f2`
      end
      #if !(@status == "ON" ||  @status == "OFF") then @status = "OUT OF SERVICE"
      #@value = "UNAVAILABLE" unless @status  =~ /\A(?:OFF|ON)\z/
      return @value
  end

  def getsecstatus
    @status = `curl --connect-timeout 0.2 http://control.maison.apoui.net/rfid/security/status`
    return @status
  end

end
