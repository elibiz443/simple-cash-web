module ApplicationHelper
  def current_user
    return @current_user if @current_user

    if session[:user_id]
      @current_user = {
        id: session[:user_id], 
        email: session[:user_email], 
        phone_number: session[:user_phone_number],
        first_name: session[:user_first_name],
        last_name: session[:user_last_name],
        balance: session[:user_balance],
        token: session[:user_token]
      }
    end
  end
end
