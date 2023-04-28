require_relative "../../config/api_config"

class ReportService
  def initialize
    @conn = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_report(authorization, report_params)
    response = @conn.post do |req|
      req.url "/api/v1/reports"
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = authorization
      req.body = report_params.to_json
    end
    JSON.parse(response.body) if response.status == 201
  end
end
