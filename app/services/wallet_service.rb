require_relative "../../config/api_config"

class WalletService
  def initialize
    @conn = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.request :url_encoded
      faraday.response :logger
    end
  end

  def fetch_wallet(authorization, id)
    response = @conn.get do |req|
      req.url "/api/v1/wallets/#{id}"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)
  end

  def fetch_wallets(authorization)
    response = @conn.get do |req|
      req.url "/api/v1/wallets"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)["wallets"]
  end
end
