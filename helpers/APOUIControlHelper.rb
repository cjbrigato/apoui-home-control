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
      @status = `curl -m 1.5 http://#{@lrelay.masterip}/#{@lrelay.localname}/status`
      #if !(@status == "ON" ||  @status == "OFF") then @status = "OUT OF SERVICE"
      @status = "UNAVAILABLE" unless @status  =~ /\A(?:OFF|ON)\z/
      return @status
  end

end
