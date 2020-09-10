require 'net/http'
require 'uri'
require 'json'
require 'httparty'

begin
  puts "ingrese ruta dal archivo: "
  namefile = gets.chomp
  content = File.read(namefile)
  puts "descripcion: "
  description = gets.chomp
  puts "Quieres el gist publico? si/no"
  public = gets.chomp
  
  if public == 'si'
    public = true
  elsif public == 'no'
    public = false
  else
    puts "respuesta incorrecta"
  end

  uri = URI.parse('https://api.github.com/gists')
  data = {
            'description' => "#{description}",
            'public' => public,
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
  request['Authorization'] = 'token bb3f0a45790a8b18bf1468c70957c55293e7fe32'
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
