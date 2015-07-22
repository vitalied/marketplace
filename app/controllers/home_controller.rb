class HomeController < AdminController

  skip_before_action :show_search, :search_items

  def index
  end

end
