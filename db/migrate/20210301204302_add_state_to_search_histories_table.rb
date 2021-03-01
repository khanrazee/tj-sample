class AddStateToSearchHistoriesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :state, :integer, default: 0
  end
end
