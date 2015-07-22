module HomeHelper

  def home_show_box?(box_name)
    can? :read, box_name.classify.constantize
  end

  def home_quotes_count
    count_scope = Quote.default_scoped
    count_scope = count_scope.by_company(current_user.userable_id) if current_user.company?

    count_scope.count
  end

  def home_companies_count
    count_scope = Company.default_scoped
    count_scope = count_scope.by_ids(current_user.userable_id) if current_user.company?

    count_scope.count
  end

  def home_locations_count
    count_scope = Location.default_scoped
    count_scope = count_scope.by_company(current_user.userable_id) if current_user.company?

    count_scope.count
  end

  def home_products_count
    count_scope = Product.default_scoped
    count_scope = count_scope.by_company(current_user.userable_id) if current_user.company?

    count_scope.count
  end

  def home_users_count
    count_scope = User.default_scoped
    count_scope = count_scope.non_admin unless current_user.admin?
    count_scope = count_scope.by_userables(current_user.userable_id) if current_user.company?

    count_scope.count
  end

end
