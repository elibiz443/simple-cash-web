require_relative "../../config/api_config"

class NotificationService
  def initialize
    @conn = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_notifications(authorization)
    response = @conn.get do |req|
      req.url "/api/v1/notifications"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)["notifications"]
  end

  def fetch_notification(authorization, id)
    response = @conn.get do |req|
      req.url "/api/v1/notifications/#{id}"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)["notification"]
  end

  def update_notification_status(authorization, id)
    response = @conn.patch do |req|
      req.url "/api/v1/notifications/#{id}"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)["notification"]
  end

  def delete_notification(authorization, id)
    response = @conn.delete do |req|
      req.url "/api/v1/notifications/#{id}"
      req.headers["Authorization"] = authorization
    end
    JSON.parse(response.body)["notification"]
  end
end
