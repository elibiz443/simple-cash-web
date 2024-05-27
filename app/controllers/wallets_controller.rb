class WalletsController < ApplicationController
  def index
    authorization = current_user[:token]
    @wallets = WalletService.new.fetch_wallets(authorization)
  end
end
