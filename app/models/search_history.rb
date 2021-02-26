class SearchHistory < ApplicationRecord
  validates_uniqueness_of :term, scope: :slug

  before_create :generate_slug,
                :save_to_dictionary

  private
  def generate_slug
    self.slug = term.parameterize(separator: '')
    self.count = 1 #Todo :move to default DB value. New migration .
  end

  def save_to_dictionary
    hashed = []
    # resp = SPELLY.spell_check = term.split(' ')
    term.split(' ').each do |word|
      dict = Dictionary.find_or_create_by(word: word.downcase)
      hashed << dict.id
    end
    self.term_hash = hashed.join(',')
  end
end
