class Saltedge::TokensService < SaltedgeService

  ENDPOINT_URL = "#{API_BASE_URL}/tokens"

  def create(params = {})
    url = "#{ENDPOINT_URL}/create"
    request(:post, url, data: params)
  end

  def reconnect(params = {})
    url = "#{ENDPOINT_URL}/reconnect"
    request(:post, url, data: params)
  end

  def refresh(params = {})
    url = "#{ENDPOINT_URL}/refresh"
    request(:post, url, data: params)
  end

end
