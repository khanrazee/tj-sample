class SearchHistory < ApplicationRecord
  # Todo: Only included to ensure to_slug is controlled via 1 place.
  include SearchesHelper

  validates_uniqueness_of :session_key
  validates :session_key, presence: true


  before_update :generate_slug

  private
  def generate_slug
    self.slug = to_slug(term)
  end
end
