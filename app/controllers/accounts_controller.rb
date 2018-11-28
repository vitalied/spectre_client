class AccountsController < ApplicationController

  def index
    begin
      @accounts     = Saltedge::AccountsService.new.list(customer_id: current_user.customer_id, login_id: params[:login_id])
      @transactions = Saltedge::TransactionsService.new.list(login_id: params[:login_id])
      @transactions += Saltedge::TransactionsService.new.pending(login_id: params[:login_id])

      @accounts_transactions = {}

      @transactions.each do |transaction|
        @accounts_transactions[transaction['account_id']] = @accounts_transactions[transaction['account_id']].to_i + 1
      end
    rescue => e
      @accounts         = []
      flash.now[:alert] = e.error['error_message']
    end
  end

end
