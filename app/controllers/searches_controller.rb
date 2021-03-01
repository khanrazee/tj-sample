class SearchesController < ApplicationController
  skip_before_action :verify_authenticity_token # Todo: Enable this for prod to avoid attacks.

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

  def create
    if params[:term]
      # Todo, Replace SearchHistory table with something like Redis or similar.
      sh = SearchHistory.find_or_create_by!(session_key: params[:search_key])
      sh.update!(term: params[:term]) if sh.slug != to_slug(params[:term])
    end
    render json: {}, status: 200
  end

end