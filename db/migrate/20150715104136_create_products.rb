class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :type, index: true
      t.references :company, index: true, foreign_key: true

      t.string :name
      t.string :custom_name
      t.string :category
      t.string :product_class
      t.string :product_type

      t.jsonb :custom_attrs

      #t.timestamps null: false
    end
  end
end
