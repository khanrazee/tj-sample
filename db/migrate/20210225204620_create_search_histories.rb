class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.text :term
      t.text :slug
      t.integer :count, default: 1
      t.string :hash_match

      t.timestamps
    end
  end
end
