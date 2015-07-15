class CreateQuoteItems < ActiveRecord::Migration
  def change
    create_table :quote_items do |t|
      t.references :quote, index: true, foreign_key: true

      t.string :network, limit: 20
      t.string :location
      t.string :location_z
      t.boolean :line_type
      t.integer :port_speed
      t.integer :access_speed
      t.integer :term, array: true, length: 2
      t.boolean :router
      t.boolean :router_z
      t.boolean :qos

      #t.timestamps null: false
    end
  end
end
