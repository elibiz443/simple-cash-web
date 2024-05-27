require_relative "../../config/api_config"

class TransactionService
  def initialize
    @conn = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def transfer_money(authorization, transaction_params)
    response = @conn.post do |req|
      req.url "/api/v1/transactions"
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = authorization
      req.body = transaction_params.to_json
    end
    JSON.parse(response.body)
  end
end
