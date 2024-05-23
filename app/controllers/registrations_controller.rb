class RegistrationsController < ApplicationController
  def create
    signup_api_client = RegistrationService.new
    response = signup_api_client.send_form_data(sign_up_params)
    
    if response
      @created_user = response["user"]
      if @created_user
        signin_api_client = SessionService.new
        @user = signin_api_client.send_form_data(sign_in_params)

        if @user
          session[:user_id] = @user["user"]["id"]
          session[:user_email] = @user["user"]["email"]
          session[:user_phone_number] = @user["user"]["phone_number"]
          session[:user_first_name] = @user["user"]["first_name"]
          session[:user_last_name] = @user["user"]["last_name"]
          session[:user_balance] = @user["user"]["balance"]
          session[:user_token] = @user["token"]

          redirect_to "/dashboard", notice: @user["message"]
        else
          flash[:alert] = "Sign in failed. Please try again."
          redirect_to "/signin"
        end
      else
        if (response["errors"]).uniq! == nil
          error = response["errors"]
        else
          error = (response["errors"]).uniq!
        end
        flash[:alert] = error.join(', ')
        redirect_to "/signup"
      end
    else
      flash[:alert] = "Registration failed. Please try again."
      redirect_to "/signup"
    end
  end

  private

  def sign_in_params
    { email: params[:email], password: params[:password] }
  end

  def sign_up_params
    {
      user: {
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        phone_number: params[:phone_number],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      }
    }
  end
end
