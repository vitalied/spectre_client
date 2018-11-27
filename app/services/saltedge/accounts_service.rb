class Saltedge::AccountsService < SaltedgeService

  ENDPOINT_URL = "#{API_BASE_URL}/accounts"

  def list(params = {})
    request(:get, ENDPOINT_URL, params)
  end

end
