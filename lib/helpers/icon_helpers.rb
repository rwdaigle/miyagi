module IconHelpers

  def characters
    @characters ||= JSON.parse(File.read("./config/font.json"))
  end
  
  # This helper is a stand-in until one of these problems is fixed:
  # 
  # 1. fontcustom supports ligatures
  # 2. webkit supports CSS transitions on :before elements
  def icon_for(word)
    return "?" unless characters.include?(word.to_s)
    "&#xf#{100 + characters.index(word.to_s)}"
  end
  
  def japan_prefectures
    %w(fukuoka kochi miyagi osaka)
  end
end