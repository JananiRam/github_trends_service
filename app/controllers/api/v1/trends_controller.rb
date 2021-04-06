class Api::V1::TrendsController < ActionController::API
  GITHUB_TREND_URL = 'https://api.github.com/search/repositories?q=created:>'.freeze
  NUMBER_OF_DAYS = 30.freeze
  def no_of_repos
    items = get_data
    render json: {'trend' => "#{params['language']} is coded in #{items.count} out of #{result["items"].count} repos"}
  end

  def list_of_repos
    items = get_data
    render json: {:list_of_repos  => items, 'trend' => "#{params['language']} is coded in #{items.count} out of #{result["items"].count} repos"}
  end


  private

  def get_data
  	params = permit_params
  	puts "params = #{params}"
  	result = call_rest_client(:get, get_github_url, 20, 20)
    result = JSON.parse(result)
    parse_response result, params['language']
  end

  def call_rest_client(method_type, url, timeout, open_timeout)
    RestClient::Request.execute(:method => method_type, :url => url, :timeout => timeout, :open_timeout => open_timeout)
  end

  def get_github_url
    time = Time.now - NUMBER_OF_DAYS.days
    GITHUB_TREND_URL + time.to_s[0..9] +"&sort=stars&order=desc"
  end

  def parse_response response, language
    result_response = []
    items = response["items"]
    return result_response if items.blank?
    items.each do |item|
      if item['language'] == language
        result_response << {:owner => item['name'], :github_url => item['html_url']}
      end
    end
    result_response
  end

  def permit_params
    params.permit(:language)
  end
end
