class AddHerokuColumnOnly < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :session_key, :string
  end
end
