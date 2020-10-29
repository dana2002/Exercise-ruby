require 'pathname'

class Received_values
  attr_reader :data

  def initialize(path, description, state)
    @path = path
    @description = description
    @state = state
  end

  def path_existence
    Dir.exist?(@path) ? self.body : puts("The path does not exist")
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
    path = Dir[@path + "/**/*"]

    path.each do |x|
      @filename = File.basename(x)
      @content = File.read(x)
      @data["files"][@filename] = content = { 'content' => @content }  
    end         
  end  
end
