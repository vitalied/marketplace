class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :company, index: true, foreign_key: true
      t.string :name
      t.string :website
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      #t.timestamps null: false
    end
  end
end
