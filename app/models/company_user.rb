class CompanyUser < User

  def company?
    true
  end

  def company
    self.userable
  end

end
