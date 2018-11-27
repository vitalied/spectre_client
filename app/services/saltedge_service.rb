class SaltedgeService

  class Error < StandardError
    attr_accessor :status, :error

    def initialize(status: nil, error: nil)
      @status = status
      @error  = error
    end
  end

  attr_reader :app_id, :secret

  API_BASE_URL    = 'https://www.saltedge.com/api/v4'
  EXPIRATION_TIME = 60

  def initialize(app_id = nil, secret = nil)
    @app_id = app_id || ENV['SALTEDGE_APP_ID']
    @secret = secret || ENV['SALTEDGE_SECRET']
  end

  def request(method, url, params = {})
    headers = {
      'Accept':       'application/json',
      'Content-type': 'application/json',
      'Expires-at':   (Time.now + EXPIRATION_TIME).to_i,
      'App-Id':       app_id,
      'Secret':       secret
    }
    args    = {
      method:  method,
      url:     url,
      payload: as_json(params),
      headers: headers
    }
    args.merge!(log: Logger.new(STDOUT)) unless Rails.env.test?

    res = RestClient::Request.execute(args)

    JSON.parse(res)['data'] rescue {}
  rescue RestClient::Exception => error
    raise SaltedgeService::Error.new(status: error.http_code, error: (JSON.parse(error.response) rescue nil))
  end

  private

    def as_json(params)
      return '' if params.empty?

      params.to_json
    end

end
