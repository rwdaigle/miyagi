class Font
  
  def self.characters
    @characters ||= JSON.parse(File.read(Rails.root.join("config/font.json")))
  end
  
end