class CreateDictionaries < ActiveRecord::Migration[5.2]
  def change
    create_table :dictionaries do |t|
      t.string :word
      t.string :slug
      t.integer :count, default: 1

      t.timestamps
    end
  end
end
