class QuoteCompany < ActiveRecord::Base

  belongs_to :quote
  belongs_to :company

  has_attached_file :offer
  do_not_validate_attachment_file_type :offer

  scope :by_company, ->(company_id) { where(company_id: company_id) }

end
