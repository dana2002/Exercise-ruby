require_relative 'request'
require_relative 'gist_content'

loop do
  puts "Ingrese nombre del archivo"
  namefile = gets.chomp
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

  values = Received_values.new(namefile, description, @state)
  values.file_existence
  if values.content != nil
    request =  Assemble.new(namefile, description, @state, values.content)
    p request
    request.body

    begin
      request.request
    rescue SocketError => exception
      p "Error de conexión"
      p "Intentar de nuevo?"
      intentar_de_nuevo = gets.chomp.capitalize

      if intentar_de_nuevo == "No"
        break
      end
    else
      if request.response.code == "201"  
        break
      end
    end
  end  
end
