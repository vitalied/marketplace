class Location < ActiveRecord::Base

  belongs_to :company

  scope :by_company, ->(company_id) { where(company: company_id) }

  def self.default_sort_column
    "locations.name"
  end

  def self.search(search, user)
    search_scope = default_scoped.includes(:company)
    search_scope = search_scope.by_company(user.userable_id) if user.company?

    if search.present?
      search = "%#{search}%"
      search_scope = search_scope.references(:company).where("companies.name ILIKE ? OR locations.name ILIKE ?", search, search)
    end

    search_scope
  end

end
