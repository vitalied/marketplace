class QuoteUser < ActiveRecord::Base

  belongs_to :quote

  validates :first_name, :last_name, :company, :phone, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def full_name
    "#{self.first_name} #{self.last_name}".strip
  end

end
