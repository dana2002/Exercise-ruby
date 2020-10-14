class Received_values
  attr_reader :content

  def initialize(namefile, description, state)
    @namefile = namefile
    @description = description
    @state = state
    @content = nil
  end

  def file_existence
   if File.exist?(@namefile)
    self.read_content
   else
    p "El archivo no existe"
   end
  end  

  def read_content
    @content = File.read(@namefile)
  end
end
