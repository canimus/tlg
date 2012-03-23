module ProductsHelper
  def layout_view?(view_type)
    view_class = "btn"
    view_class += " active" if view_type==session[:view_layout]
    view_class
  end
  
  def page_per_view?(index)
    view_class = "btn"
    view_class += " active" if index==session[:page_size].to_i
    view_class
  end
  
end
