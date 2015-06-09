class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :userable, polymorphic: true

  scope :non_admin, -> { where.not(type: AdminUser) }
  scope :by_userables, ->(userables) { where(userable: userables) }
  scope :for_hash, ->(ids) { non_admin.where(id: ids) }

  before_update :clear_userable, if: :type_changed?
  before_update :set_userable, if: :userable_id_changed?

  def self.default_sort_column
    "first_name"
  end

  def self.search(search, user)
    search_scope = default_scoped
    search_scope = search_scope.non_admin unless user.is_a?(AdminUser)
    search_scope = search_scope.by_userables(user.userable_id) if user.company?

    if search.present?
      search = "%#{search}%"
      search_scope = search_scope.where("first_name ILIKE ? OR last_name ILIKE ? OR title ILIKE ?", search, search, search)
    end

    search_scope
  end

  def admin?
    false
  end

  def company?
    false
  end

  def full_name
    "#{self.first_name} #{self.last_name}".strip
  end

  def company
  end

  private

    def clear_userable
      self.userable = nil
    end

    def set_userable
      self.userable = Company.find(self.userable_id) if self.userable_id
    end

end
