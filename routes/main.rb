class APOUIControl < Sinatra::Base
  #not_found do
  #  unless request.path_info =~ /^\/api(.*)/i
  #    title 'Not Found!'
  #    erb :not_found, layout: false
  #  end
  #end

  before do
    cache_control max_age: 10
    # placeholder
  end

  namespace '/api' do
    get '/relays/?' do
        content_type :json
        @relays = $relays
        erb :apirelays, layout: false
    end

    get '/sensors/?' do
        content_type :json
        @sensors = $sensors
        erb :apisensors, layout: false
    end
  end


  get '/' do
    #redirect '/login'
    title 'APOUI Home Automation Control'
    @total_relays="6"
    @total_controllers="7"
    @total_sensors="3"
    @hostname="architect"
    @ip_address="192.168.1.252"
    @system="Debian GNU/Linux 8"
    @uptime=`uptime | awk '{print $1}'`
    erb :home
  end

  get '/rfid/tagaction/:tagid' do
      @tagid = params[:tagid].upcase 
      @exec = `bash rfid/scripts/#{@tagid}.sh`
      @date = `date | tr -d '\n'`
      @log = `echo "[#{@date}] - #{@tagid} Tagaction" >> logs/rfid.log`  
  end

  get '/rfid/security/status' do
      @secstatus = `cat rfid/security.status`
      return @secstatus
  end

  get '/apoui-bin/' do
	@spawn =`apouictl/apouictl`
  	return @spawn
  end
  get '/apoui-bin/:id' do
	@spawn =`apouictl/apouictl #{params[:id]}`
	return @spawn
  end

  get '/doorlog/add/:message' do
      @date = `date | tr -d '\n'`
      @message = params[:message]
      `echo "[#{@date}] - Door is now #{@message}" >> logs/doorlock.log`
      if @message =~ /^OPEN/ 
         @spawn = `rfid/security-process.sh &`
     end
  end 

  get '/doorlog/log/?' do
      @logs = `tac logs/doorlock.log | head -n50`
      erb :doorlog
  end
	

  get '/relaycontrol/?' do
      @do = 'yes'
      return erb :relaycontrol unless @do == 'yes'
      @q = params[:q]
      @relays = $relays
      erb :relaycontrol
  end
 
  get '/sensorinfo/?' do
      @do = 'yes'
      return erb :sensorinfo unless @do == 'yes'
      @q = params[:q]
      @sensors = $sensors
      erb :sensorinfo
  end

  get '/getrelaystatus/:id' do
      @rid = params[:id].to_i
      @status = getrelaystatus(@rid)
      return @status
  end

  get '/getsensorvalue/:id' do
      @sid = params[:id].to_i
      @value = getsensorvalue(@sid)
      return @value
  end

  get '/setrelay/:id/:status' do
      #todo check existence et status
      @rid = params[:id].to_i
      @status = params[:status]
      @srelay = $relays.select { |relay| relay.id == @rid }
      @srelay.each do |relay|
        @lrelay = relay
      end
      `curl --connect-timeout 0.2 http://#{@lrelay.masterip}/#{@lrelay.localname}/#{@status}`
      "#{@lrelay.name} set to #{@status}"
  end

  get '/switchrelay/:id' do
      @sid = params[:id]
      @rid = @sid.to_i
      @srelay = $relays.select { |relay| relay.id == @rid }
      @srelay.each do |relay|
        @lrelay = relay
      end
      @istatus = `curl --connect-timeout 0.2 http://#{@lrelay.masterip}/#{@lrelay.localname}/status`
      if @istatus == "ON"
        @nstatus = "off"
      elsif @istatus == "OFF"
        @nstatus = "on"
      end
      `curl --connect-timeout 0.2 http://#{@lrelay.masterip}/#{@lrelay.localname}/#{@nstatus}`
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

  get '/sensors/?' do
      @do = 'yes'
      return erb :sensors unless @do == 'yes'
      @q = params[:q]
      @sensors = $sensors
      erb :sensors
  end

  get '/houseview/?' do
     return erb :houseview
  end

end
