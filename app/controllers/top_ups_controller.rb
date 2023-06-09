class TopUpsController < ApplicationController
  def create
    authorization = current_user[:token]
    @top_up = TopupService.new.create_topup(authorization, top_up_params)

    if @top_up
      redirect_to "/top_ups", notice: @top_up["message"]
    else
      redirect_to "/top_ups", alert: "Error please try again!"
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
    {amount: params[:amount], phone_number: params[:phone_number]}
  end
end
