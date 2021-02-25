class SearchesController < ApplicationController
  require 'tss/tss'

  def suggestions #Todo : Change name
    #Todo Move to Service.
    if params[:term]
      dictionary = Dictionary.all.map(&:word) #Todo: Just to solve the problem. Never for Production
      tss = TSS::Trie.new(dictionary, :full)
      term = params[:term].downcase.parameterize(separator: '')
      @hits = tss.parse(params[:term].downcase)
      search_history = SearchHistory.where("slug LIKE '#{term}%' ")
      puts @hits.inspect
      if search_history.present?
        #Todo: Fix this.
        search_history.each do |sh|
          if term.split.length > sh.slug.split.length
            sh.update(slug: term, term: params[:term], count: sh.count + 1)
          end
        end
      else
        SearchHistory.create(term: params[:term])
      end

      #Todo: serialize.
      response = []
      search_history.each do |sh|
        response << { label: sh.term, value: sh.term, hits: @hits}
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