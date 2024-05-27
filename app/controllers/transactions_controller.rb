class TransactionsController < ApplicationController
  def create
    authorization = current_user[:token]
    @transaction = TransactionService.new.transfer_money(authorization, transaction_params)

    if @transaction
      @created_transaction = @transaction["transaction"]
      if @created_transaction
        redirect_to "/transactions", notice: @transaction["message"]
      else
        redirect_to "/transactions", alert: @transaction["errors"].join(', ')
      end
    else
      redirect_to "/transactions", alert: "Transaction failed. Please try again!"
    end
  end
  
  private

  def transaction_params
    {amount: params[:amount], phone_number_or_email: params[:phone_number_or_email], currency: params[:currency], user_id: params[:user_id]}
  end
end
