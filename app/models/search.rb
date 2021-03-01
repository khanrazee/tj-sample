class Search < ApplicationRecord
  validates :term, :slug, uniqueness: true
  validates :slug, presence: true

end
