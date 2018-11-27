class Saltedge::TransactionsService < SaltedgeService

  ENDPOINT_URL = "#{API_BASE_URL}/transactions"

  def list(params = {})
    request(:get, ENDPOINT_URL, params)
  end

  def pending(params = {})
    url = "#{ENDPOINT_URL}/pending"
    request(:get, url, params)
  end

end
