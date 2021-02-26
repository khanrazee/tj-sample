class SearchesController < ApplicationController
  require 'tss/tss'

  def suggestions #Todo : Change name
    #Todo Move to Service.
    if params[:term]
      dictionary = Dictionary.where(word: params[:term].downcase.split()) #Todo: Just to solve the problem. Never for Production
      # tss = TSS::Trie.new(dictionary, :full)
      # @hits = tss.parse(params[:term].downcase)
      term = params[:term].downcase.parameterize(separator: '')
      search_history = SearchHistory.where("slug LIKE '#{term}%' ")
      if search_history.present?
        #Todo: Fix this.
        # search_history.each do |sh|
        #   if term.split.length > sh.slug.split.length
        #     sh.update(slug: term, term: params[:term], count: sh.count + 1)
        #   end
        # end
      else
        SearchHistory.create(term: params[:term])
      end

      #Todo: serialize.
      response = []
      words = []
      prev = nil
      dictionary.each do |d|
        words << { word: d.word, hash_id: d.id }
      end
      search_history.each do |sh|
        response << { label: sh.term, value: sh.term, hits: words, term_hash: sh.term_hash }
        # if prev && prev.term_hash.split(',').length <= sh.term_hash.split(',').length
        #   response = { label: sh.term, value: sh.term, hits: words, term_hash: sh.term_hash }
        # end
        # prev = sh
      end
      return render json: response, status: 200
    end
    # SearchHistory.delete_all
    return render json: [], status: 200
  end

  def index
    @search_history = SearchHistory.limit(200)
  end


end



# what is your name
# what is your
# what is your name and number

#whatisyourname
#whatisyour
#whatisyournameandnumber