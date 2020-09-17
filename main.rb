require_relative 'request.rb'
require_relative 'gist_content'

puts "Ingrese nombre del archivo "
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
request =  Assemble.new(namefile, description, @state, @content)
values.file_existence

# p @content
request.body
request.request