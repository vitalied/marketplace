class Product < ActiveRecord::Base

  belongs_to :company

  CUSTOM_ATTRS = [:circuit_type, :speed, :ip_block, :connectivity_type]

  serialize :custom_attrs, HashSerializer
  store_accessor :custom_attrs, CUSTOM_ATTRS

  scope :by_company, ->(company_id) { where(company: company_id) }

  before_update :clear_attrs, if: :category_changed?
  before_update :clear_product_type, if: :product_class_changed?

  def self.default_sort_column
    "products.name"
  end

  def self.search(search, user)
    search_scope = default_scoped.includes(:company)
    search_scope = search_scope.by_company(user.userable_id) if user.company?

    if search.present?
      search = "%#{search}%"
      search_scope = search_scope.references(:company).where("companies.name ILIKE ? OR products.name ILIKE ?", search, search)
    end

    search_scope
  end

  private

    def clear_attrs
      self.product_class = nil
      self.product_type = nil
      self.custom_attrs = nil
    end

    def clear_product_type
      self.product_type = nil
      self.custom_attrs = nil
    end

end
