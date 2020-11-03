require 'pathname'

# @author Dana
# This class receives the values ​​from the gist.
class Received_values
  # To be able to call the data variable from another class
  attr_reader :data

  # Initialize the variables of the class:
  # 'path' is the path of the files,
  # 'description' is the description of the gist,
  # 'state' is if the gist is private or not (of type boolean).
  def initialize(path, description, state)
    @path = path
    @description = description
    @state = state
  end

  # Verify that the path passed exists.
  def path_existence
    Dir.exist?(@path) ? self.body : puts("The path does not exist")
  end
   
  # Has a hash with the body of the gist and calls the read_path method.
  def body
    @data = {
      'description' => @description,
      'public' => @state,
      'files' => {
      }
    }
    self.read_path
  end
  
  # Reads and iterates over the path, reading each file and its content and adding them to the hash
  def read_path
    path = Dir[@path + "/**/*"]

    path.each do |x|
      @filename = File.basename(x)
      @content = File.read(x)
      @data["files"][@filename] = content = { 'content' => @content }  
    end         
  end  
end
