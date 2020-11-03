require 'net/http'
require 'uri'
require 'json'
require 'httparty'
require 'dotenv'

URL = 'https://api.github.com/gists'

# @author Dana
# Make the gist request.
class Assemble
  # To be able to call the response variable from another class.
  attr_reader :response

  # Initialize the variables of the class:
  # 'data' is the hash with the body of the gist.
  def initialize(data)
    @data = data
  end
  
  # Makes the request post to the api and returns the url of the gist.
  def request
    uri = URI.parse(URL)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    Dotenv.load
    request['Authorization'] = "token #{ENV['GITHUB_ACCESS_TOKEN']}"
    request.body = @data.to_json

    @response = http.request(request)
    json = @response.body
    url = JSON.parse(json)

    puts url['url']
  end
end
