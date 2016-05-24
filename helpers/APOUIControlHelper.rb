module APOUIControlHelper

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

  def title(value = nil)
    @title = value if value
    @title ? "Briganious- APOUI HOME CONTROL #{@title}" : 'APOUI!'
  end

end
