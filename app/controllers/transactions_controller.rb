class TransactionsController < ApplicationController
    def create
    authorization = current_user[:token]
    @transaction = TransactionService.new.transfer_money(authorization, transaction_params)

    if @transaction
      redirect_to "/transactions", notice: @transaction["message"]
    else
      redirect_to "/transactions", alert: "Error please try again!"
    end
  end
  
  private

  def transaction_params
    {amount: params[:amount], phone_number_or_email: params[:phone_number_or_email]}
  end
end
