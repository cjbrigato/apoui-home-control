class APOUIControl < Sinatra::Base
  register Sinatra::Session
  register Sinatra::Namespace
  register Sinatra::MultiRoute

  set :root, File.join(File.expand_path(File.dirname(__FILE__)), '..')

  set :logging, true

  set :environment, :development
  # set :environment, :production

  set :method_override, true

  set :session_fail, '/login'
  set :session_secret, 'm4yTH3ForcB1'

  set :show_exceptions, false

  # error do
  #	content_type :json
  # status 500 # or whatever
  #	e = env['sinatra.error']
  #	{:result => 'error', :class => e.class, :message => e.message}.to_json
  # end

  error do
    e = env['sinatra.error']
    "<pre>
    Hello. This is Error.
    =====

     * <strong>Error Class :</strong> #{e.class}
     * <strong>Error Message :</strong> #{e.message}

    <a href='/web'>Back To Dashboard</a>
    </pre>"
  end
  # error do
  #	exception = env['sinatra.error']
  #	erb :exception
  # end

end
