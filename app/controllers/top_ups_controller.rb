class TopUpsController < ApplicationController
  def create
    authorization = current_user[:token]
    topup_api_client = TopupService.new
    response = topup_api_client.create_topup(authorization, top_up_params)
    
    if response
      @created_top_up = response["top_up"]
      if @created_top_up
        redirect_to "/top_ups", notice: @top_up["message"]
      else
        # if (response["errors"]).uniq! == nil
        #   error = response["errors"]
        # else
        #   error = (response["errors"]).uniq!
        # end
        # flash[:alert] = error.join(', ')
        flash[:alert] = "Top up failed. Please try again!"
        redirect_to "/top_ups"
      end
    else
      flash[:alert] = "Top up failed. Please try again!"
      redirect_to "/top_ups"
    end
  end

  def show
    authorization = current_user[:token]
    id = current_user[:id]
    user = TopupService.new.fetch_user(authorization, id)
    @balance = user["balance"]
  end

  private

  def top_up_params
    {amount: params[:amount], phone_number: params[:phone_number], wallet_id: params[:wallet_id], currency: params[:currency]}
  end
end
