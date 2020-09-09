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
  request['Authorization'] = 'token c90f2da8cea3cef00e96e96bc1433d7024479715'

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
