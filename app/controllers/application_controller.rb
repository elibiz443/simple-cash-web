class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_user!

  private

  def authenticate_user!
    if (controller_name == "dashboard") 
      redirect_to "/signin" unless current_user
    elsif (controller_name == "home") 
      redirect_to "/dashboard" if current_user
    end
  end
end
