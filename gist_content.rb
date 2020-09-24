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
    Dir[@namefile + "/**/*"].each do |f|
      @content = File.read(f)
      p @content
    # @content = File.read(@namefile)
    end
  end
end
