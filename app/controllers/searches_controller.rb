class SearchesController < ApplicationController
  include SearchesHelper

  def suggestions #Todo : Change name or move to index?
    if params[:term]
      search_history = Search.where("slug LIKE '#{to_slug(params[:term])}%' ")

      resp = search_history.map{ |sh| { label: sh.term, value: sh.term } }
      return render json: resp, status: 200
    end
    return render json: [], status: 200
  end

  def index
    @searches = Search.limit(10)
  end

end