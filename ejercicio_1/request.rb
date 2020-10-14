require 'net/http'
require 'uri'
require 'json'
require 'httparty'
require 'dotenv'

URL = 'https://api.github.com/gists'

class Assemble
  attr_reader :response

  def initialize(namefile, description, state, content)
    @namefile = namefile
    @description = description
    @state = state
    @content = content
  end 

  def body
    @data = {
      'description' => @description,
      'public' => @state,
      'files' => {
        @namefile => {
          'content' => @content
        }
      }
    }
  end

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
