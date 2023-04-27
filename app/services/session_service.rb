require_relative "../../config/api_config"

class SessionService
  def initialize
    @conn = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.request :url_encoded
      faraday.response :logger
    end
  end

  def send_form_data(sign_in_params)
    response = @conn.post do |req|
      req.url "/api/v1/login"
      req.headers["Content-Type"] = "application/json"
      req.body = sign_in_params.to_json
    end
    JSON.parse(response.body) if response.status == 201
  end
end
