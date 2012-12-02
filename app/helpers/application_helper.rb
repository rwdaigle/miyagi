module ApplicationHelper

  def user_label(user)
    if(user)
      label = user.name.blank? ? user.label : user.name
      label = user.email_fragment unless label
    end
    label ? label : "Anonymous"
  end
  
  # This helper is a stand-in until one of these problems is fixed:
  # 
  # 1. fontcustom supports ligatures
  # 2. webkit supports CSS transitions on :before elements
  def icon_for(word)
    words = %w(fukuoka github moon sun twitter)
    return "?" unless words.include?(word.to_s)
    "&#xf#{100 + words.index(word.to_s)}".html_safe
  end
  
end