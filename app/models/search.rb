class Search < ApplicationRecord
  validates :term, :slug, uniqueness: true

end
