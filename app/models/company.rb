class Company < ActiveRecord::Base

  has_many :locations
  has_many :company_users, as: :userable

  scope :by_ids, ->(ids) { where(id: ids) }
  scope :for_hash, ->(ids) { where(id: ids).where.not(name: nil).pluck(:id, :name) }

  def self.default_sort_column
    "name"
  end

  def self.search(search, user)
    search_scope = default_scoped
    search_scope = search_scope.by_ids(user.userable_id) if user.company?

    if search.present?
      search = "%#{search}%"
      search_scope = search_scope.where("name ILIKE ?", search)
    end

    search_scope
  end

end
