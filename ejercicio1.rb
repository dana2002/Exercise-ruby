require 'net/http'
require 'uri'
require 'json'
require 'httparty'
require 'dotenv'

URL = 'https://api.github.com/gists'

begin
  puts "Ingrese nombre del archivo "
  namefile = gets.chomp
  content = File.read(namefile)
  puts "Descripcion: "
  description = gets.chomp
  
  loop do
    puts "Quieres el gist publico? Si/No"
    state = gets.chomp.capitalize
  
    if state == 'Si'
      @state = true
      break
    elsif state == 'No'
      @state = false
      break
    else
      puts "Respuesta incorrecta"
    end
  end

  uri = URI.parse(URL)
  data = {
            'description' => description,
            'public' => @state,
            'files' => {
              namefile => {
                'content' => content
              }
            }
          }

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Post.new(uri.request_uri)
  Dotenv.load
  request['Authorization'] = "token #{ENV['GITHUB_ACCESS_TOKEN']}"
  request.body = data.to_json

  response = http.request(request)
  json = response.body
  url = JSON.parse(json)

  puts url['url']

rescue Errno::ENOENT => e 
  p "Archivo no encontrado"
  retry
rescue SocketError => exception
  p "Error de conexión"
  retry
end
