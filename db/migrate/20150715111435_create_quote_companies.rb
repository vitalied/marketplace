class CreateQuoteCompanies < ActiveRecord::Migration
  def change
    create_table :quote_companies do |t|
      t.references :quote, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true

      t.attachment :offer

      #t.timestamps null: false
    end
  end
end
