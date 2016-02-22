module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end


  module HeadersHelpers
    def api_header(version = 1)
      request.headers['Accept'] = "application/vnd.hotels_booking.v#{version}"
    end

    def api_response_format(format = Mime::JSON)
      request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
      request.headers['Content-Type'] = format.to_s
    end

    def api_authorization_header(token)
      request.headers['Authorization'] = token
    end

    def default_api_authorization_header
      @client = FactoryGirl.create :client
      request.headers['Authorization'] = @client.auth_token
    end

    def include_default_accept_headers
      api_header
      api_response_format
      default_api_authorization_header
    end
  end
end