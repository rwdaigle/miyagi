module ApplicationHelper

  def user_label(user)
    if(user)
      label = user.name.blank? ? user.label : user.name
      label = user.email_fragment unless label
    end
    label ? label : "Anonymous"
  end
end