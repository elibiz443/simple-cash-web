require_relative "../../config/api_config"

class SessionsController < ApplicationController
  def create
    api_client = SessionService.new
    @user = api_client.send_form_data(sign_in_params)

    if @user && @user["user"]
      session[:user_id] = @user["user"]["id"]
      session[:user_email] = @user["user"]["email"]
      session[:user_phone_number] = @user["user"]["phone_number"]
      session[:user_first_name] = @user["user"]["first_name"]
      session[:user_last_name] = @user["user"]["last_name"]
      session[:user_token] = @user["token"]

      redirect_to "/dashboard", notice: @user["message"]
    else
      redirect_to "/signin", alert: "Invalid email or password ❌"
    end
  end

  def destroy
    Faraday.delete("#{API_BASE_URL}/api/v1/logout", {}, {"Authorization" => "Bearer #{session[:user_token]}"}).then do
      reset_session
      redirect_to "/signin", notice: "Logged Out!!"
    end
  end

  private

  def sign_in_params
    { email: params[:email], password: params[:password] }
  end
end
