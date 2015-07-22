module UsersHelper

  def hash_options_for_role
    {
      AdminUser: "Admin",
      CompanyUser: "Company"
    }
  end

  def role_name(role)
    hash_options_for_role[role]
  end

end
