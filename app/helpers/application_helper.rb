module ApplicationHelper
  def clr_both
    return "<div class='clr'></div>"
  end


  def active_class(controller_name)
    'active' if controller.controller_path == controller_name
  end

  def format_text(text_size, text)
    text.size > (text_size - 3) ? (text.slice(0..text_size)+"...") : text
  end

end
