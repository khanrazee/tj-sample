class SearchHistory < ApplicationRecord
  validates_uniqueness_of :term, scope: :slug

  before_create :generate_slug
  after_create :save_to_dictionary

  private
  def generate_slug
    self.slug = term.parameterize(separator: '')
    self.count = 1 #Todo :move to default DB value. New migration .
  end

  def save_to_dictionary
    term.split(' ').each do |word|
      Dictionary.find_or_create_by(word: word.downcase)
    end
  end
end
