class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :number, limit: 10

      t.timestamps null: false
    end

    add_index :quotes, :number, unique: true
  end
end
