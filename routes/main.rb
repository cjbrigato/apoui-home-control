class APOUIControl < Sinatra::Base
  #not_found do
  #  unless request.path_info =~ /^\/api(.*)/i
  #    title 'Not Found!'
  #    erb :not_found, layout: false
  #  end
  #end

  before do
    cache_control max_age: 2
    # placeholder
  end

  get '/' do
    #redirect '/login'
    title 'APOUI Home Automation Control'
    @total_relays="4"
    @total_controllers="2"
    @hostname="architect"
    @ip_address="192.168.1.252"
    @system="Debian GNU/Linux 8"
    @uptime=`uptime | awk '{print $1}'`
    erb :home
  end

  get '/relaycontrol/?' do
      @do = 'yes'
      return erb :relaycontrol unless @do == 'yes'
      @q = params[:q]
      @relays = $relays
      erb :relaycontrol
  end

  get '/getrelaystatus/:id' do
      @rid = params[:id].to_i
      @status = getrelaystatus(@rid)
      return @status
  end

  get '/setrelay/:id/:status' do
      #todo check existence et status
      @rid = params[:id].to_i
      @status = params[:status]
      @srelay = $relays.select { |relay| relay.id == @rid }
      @srelay.each do |relay|
        @lrelay = relay
      end
      `curl -m 1.5 http://#{@lrelay.masterip}/#{@lrelay.localname}/#{@status}`
      "#{@lrelay.name} set to #{@status}"
  end

  get '/switchrelay/:id' do
      @sid = params[:id]
      @rid = @sid.to_i
      @srelay = $relays.select { |relay| relay.id == @rid }
      @srelay.each do |relay|
        @lrelay = relay
      end
      @istatus = `curl -m 1.5 http://#{@lrelay.masterip}/#{@lrelay.localname}/status`
      if @istatus == "ON"
        @nstatus = "off"
      elsif @istatus == "OFF"
        @nstatus = "on"
      end
      `curl http://#{@lrelay.masterip}/#{@lrelay.localname}/#{@nstatus}`
      "#{@lrelay.name} SWITCHED to #{@nstatus}"
  end

  get '/onerelay/:id' do
     @sid = params[:id]
      @rid = @sid.to_i
      @srelay = $relays.select { |relay| relay.id == @rid }
      @srelay.each do |relay|
        @lrelay = relay
      end
      return erb :onerelay, layout: false
  end 

  get '/relays/?' do
      @do = 'yes'
      return erb :relays unless @do == 'yes'
      @q = params[:q]
      @relays = $relays
      erb :relays
  end

  get '/houseview/?' do
     return erb :houseview
  end

end
