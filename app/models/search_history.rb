class SearchHistory < ApplicationRecord
  validates_uniqueness_of :term, scope: :slug

  before_create :generate_slug

  private
  def generate_slug
    self.slug = term.parameterize(separator: '')
  end
end
