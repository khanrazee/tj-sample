class SearchesController < ApplicationController
  def suggestions #Todo : Change name
    #Todo Move to Service.
    if params[:term]
      term = params[:term].downcase.parameterize(separator: '')
      search_history = SearchHistory.where("slug LIKE '#{term}%' ").first

      if search_history
        if term.split.length > search_history.slug.split.length
          search_history.update(slug: term, term: params[:term], count: search_history.count + 1)
        end
      else
        SearchHistory.create(term: params[:term])
      end
      return render json: { label: search_history.term, value: search_history.term }, status: 200
    end
    return render json: [], status: 200
  end

  def index

  end
end



# what is your name
# what is your
# what is your name and number

#whatisyourname
#whatisyour
#whatisyournameandnumber