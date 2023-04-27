require_relative "../../config/api_config"

class TopupService
  def initialize
    @conn = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def create_topup(authorization, top_up_params)
    response = @conn.post do |req|
      req.url "/api/v1/top_ups"
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = authorization
      req.body = top_up_params.to_json
    end
    JSON.parse(response.body) if response.status == 201
  end

  def fetch_user(authorization, id)
    response = @conn.get do |req|
      req.url "/api/v1/users/#{id}"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)["user"]
  end
end
