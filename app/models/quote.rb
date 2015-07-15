class Quote < ActiveRecord::Base

  has_many :quote_companies
  has_many :companies, through: :quote_companies
  has_one :quote_user
  accepts_nested_attributes_for :quote_user
  has_many :quote_items
  accepts_nested_attributes_for :quote_items

  scope :by_company, ->(company_id) { includes(:quote_companies).where(quote_companies: { company_id: company_id}) }

  after_create :set_number

  def self.default_sort_column
    "number"
  end

  def self.search(search, user)
    search_scope = default_scoped
    search_scope = search_scope.by_company(user.userable_id) if user.company?

    if search.present?
      search = "%#{search}%"
      search_scope = search_scope.where("number ILIKE ?", search)
    end

    search_scope
  end

  private

    def set_number
      self.update_column(:number, "QUOTE-#{self.id}")
    end

end
