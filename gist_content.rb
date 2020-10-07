require 'pathname'

class Received_values
  attr_reader :data

  def initialize(pathname, description, state)
    @pathname = pathname
    @description = description
    @state = state
    @content = nil
  end

  def path_existence
    if Dir.exist?(@pathname)
     self.body
    else
     p "La ruta no existe"
    end
   end
   
  def body
    @data = {
      'description' => @description,
      'public' => @state,
      'files' => {
      }
    }
    self.read_path
  end
  
  def read_path
    path = Dir[@pathname + "/**/*"]
    path.each do |x|
      @filename = File.basename(x)
      @content = File.read(x)
      @data["files"][@filename] = content = {'content' => @content} 
    end                  
    # p @data
  end  
end
