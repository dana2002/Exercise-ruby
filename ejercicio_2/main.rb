require_relative 'request'
require_relative 'gist_content'

loop do
  puts "Enter the path:"
  path = gets.chomp
  puts "Description:"
  description = gets.chomp

  loop do
    puts "Do you want the public gist? Yes/No"
    state = gets.chomp.capitalize

    if state == 'Yes'
      @state = true
      break
    elsif state == 'No'
      @state = false
      break
    else
      puts "Wrong answer"
    end
  end

  values = Received_values.new(path, description, @state)
  values.path_existence

  if values.data
    values.body
    request = Assemble.new(description, @state, values.data)

    begin
      request.request
    rescue SocketError => exception
      p "Connection error"
      p "Try again?"
      try_again = gets.chomp.capitalize

      break if try_again == "No"
    else
      break if request.response.code == "201"  
    end
  end
end
