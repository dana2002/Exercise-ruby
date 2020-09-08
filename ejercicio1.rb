require 'net/http'
require 'uri'
require 'json'
require 'httparty'

begin
  puts "nombre del archivo: "
  namefile = gets.chomp
  content = File.read(namefile)

  puts "descripcion: "
  description = gets.chomp
  puts "public: "
  public = gets.chomp

  uri = URI.parse('https://api.github.com/gists')


  data = {
            'description' => "#{description}",
            'public' => "#{public}",
            'files' => {
              "#{namefile}" => {
                'content' => "#{content}"
              }
            }
          }
        

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Post.new(uri.request_uri)
  request['Authorization'] = 'token eb84f8680cdf37d2a1e4ff58cdc432f336412757'

  request.body = data.to_json
  response = http.request(request)

  json = response.body
  url = JSON.parse(json)

  puts url['url']
  
rescue => exception
  p exception.message
  retry
end
