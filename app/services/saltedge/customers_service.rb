class Saltedge::CustomersService < SaltedgeService

  ENDPOINT_URL = "#{API_BASE_URL}/customers"

  def list(params = {})
    request(:get, ENDPOINT_URL, params)
  end

  def create(params = {})
    request(:post, ENDPOINT_URL, data: params)
  end

end
