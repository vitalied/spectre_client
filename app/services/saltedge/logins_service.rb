class Saltedge::LoginsService < SaltedgeService

  ENDPOINT_URL = "#{API_BASE_URL}/logins"

  def list(params = {})
    request(:get, ENDPOINT_URL, params)
  end

  def remove(params = {})
    url = "#{ENDPOINT_URL}/#{params[:id]}"
    request(:delete, url)
  end

end
