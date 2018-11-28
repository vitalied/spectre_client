class ConnectionsController < ApplicationController

  def index
    begin
      @connections = Saltedge::LoginsService.new.list(customer_id: current_user.customer_id)
      @accounts    = Saltedge::AccountsService.new.list(customer_id: current_user.customer_id)

      @connections_accounts = {}

      @accounts.each do |account|
        @connections_accounts[account['login_id']] = @connections_accounts[account['login_id']].to_i + 1
      end
    rescue => e
      @connections      = []
      flash.now[:alert] = e.error['error_message']
    end
  end

  def new
    begin
      token = Saltedge::TokensService.new.create(
        customer_id:  current_user.customer_id,
        fetch_scopes: [:accounts, :transactions],
        return_to:    connections_url
      )
      redirect_to token['connect_url']
    rescue => e
      redirect_to connections_path, alert: e.error['error_message']
    end
  end

  def reconnect
    begin
      token = Saltedge::TokensService.new.reconnect(
        login_id:     params[:id],
        fetch_scopes: [:accounts, :transactions],
        return_to:    connections_url
      )
      redirect_to token['connect_url']
    rescue => e
      redirect_to connections_path, alert: e.error['error_message']
    end
  end

  def refresh
    begin
      token = Saltedge::TokensService.new.refresh(
        login_id:     params[:id],
        fetch_scopes: [:accounts, :transactions],
        return_to:    connections_url
      )
      redirect_to token['connect_url']
    rescue => e
      redirect_to connections_path, alert: e.error['error_message']
    end
  end

  def destroy
    begin
      Saltedge::LoginsService.new.remove(id: params[:id])

      redirect_to connections_path, notice: "Connection ##{params[:id]} was deleted."
    rescue => e
      redirect_to connections_path, alert: e.error['error_message']
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_params
      params.permit(:login, :password)
    end

    def validate_connection
      @connection_errors = []
      [:login, :password].each { |p| @connection_errors << "#{p.capitalize} can't be blank" if connection_params[p].blank? }
    end

end
