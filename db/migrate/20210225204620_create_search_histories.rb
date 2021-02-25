class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.text :term
      t.text :slug
      t.integer :count
      t.string :hash_match

      t.timestamps
    end
  end
end
