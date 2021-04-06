class TrendUtils
  GITHUB_TREND_URL = 'https://api.github.com/search/repositories?q=created:>'
  def self.call_rest_client(method_type, url, timeout, open_timeout)
    RestClient::Request.execute(:method => method_type, :url => url, :timeout => timeout, :open_timeout => open_timeout)
  end

  def self.get_github_url
  	time = Time.now - 30.days
	GITHUB_TREND_URL + time.to_s[0..9] +"&sort=stars&order=desc"
  end
end
