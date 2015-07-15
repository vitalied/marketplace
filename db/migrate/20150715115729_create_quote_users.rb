class CreateQuoteUsers < ActiveRecord::Migration
  def change
    create_table :quote_users do |t|
      t.references :quote, index: true, foreign_key: true

      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :company, limit: 100
      t.string :email, limit: 100
      t.string :phone, limit: 20

      #t.timestamps null: false
    end
  end
end
