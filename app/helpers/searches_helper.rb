module SearchesHelper
  def to_slug term
    term.downcase.parameterize(separator: '')
  end
end
