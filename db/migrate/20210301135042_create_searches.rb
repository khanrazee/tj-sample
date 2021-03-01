class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.text :term
      t.integer :count, default: 0
      t.text :slug

      t.timestamps
    end
  end
end
