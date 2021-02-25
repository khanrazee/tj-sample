class SearchHistory < ApplicationRecord
  validates_uniqueness_of :term, scope: :slug

  before_create :generate_slug

  private
  def generate_slug
    self.slug = term.parameterize(separator: '')
    self.count = 1 #Todo :move to default DB value. New migration .
  end
end
