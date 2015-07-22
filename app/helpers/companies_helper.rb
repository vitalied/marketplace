module CompaniesHelper

  def hash_options_for_company(company_id = nil)
    Company.for_hash(company_id).to_h
  end

end
