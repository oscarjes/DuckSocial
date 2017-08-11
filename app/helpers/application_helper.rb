module ApplicationHelper
  
  def icon(icon_name, text)
    content_tag(:span, fa_icon(icon_name), class: "icon") + content_tag(:span, text)
  end

end
