class Quote < ActiveRecord::Base

  after_create :set_number

  def self.default_sort_column
    "number"
  end

  def self.search(search, user)
    search_scope = default_scoped

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
