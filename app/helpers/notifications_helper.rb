module NotificationsHelper
  def unread_notifications
    authorization = current_user[:token]
    notifications = NotificationService.new.fetch_notifications(authorization)
    notifications.select { |n| n["status"] == "unread" }
  end
end