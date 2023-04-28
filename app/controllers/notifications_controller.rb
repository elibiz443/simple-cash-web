class NotificationsController < ApplicationController
  def index
    authorization = current_user[:token]
    @notifications = NotificationService.new.fetch_notifications(authorization)
  end

  def show
    authorization = current_user[:token]
    id = params[:id]
    @notification = NotificationService.new.fetch_notification(authorization, id)
    if @notification
      NotificationService.new.update_notification_status(authorization, id)
    end
  end

  def destroy
    authorization = current_user[:token]
    id = params[:id]
    @notification = NotificationService.new.delete_notification(authorization, id)
    redirect_to "/notifications", notice: "Notification deleted successfully ❌"
  end
end
