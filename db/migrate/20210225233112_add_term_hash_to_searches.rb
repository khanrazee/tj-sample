class AddTermHashToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :term_hash, :text
  end
end
