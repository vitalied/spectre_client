class TransactionsController < ApplicationController

  def index
    begin
      @transactions = Saltedge::TransactionsService.new.list(account_id: params[:account_id])
      @transactions += Saltedge::TransactionsService.new.pending(account_id: params[:account_id])
    rescue => e
      @transactions     = []
      flash.now[:alert] = e.error['error_message']
    end
  end

end
