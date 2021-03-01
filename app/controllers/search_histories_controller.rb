class SearchHistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token # Todo: Enable this for prod to avoid attacks.

  include SearchesHelper

  def create
    if params[:term]
      # Todo, Replace SearchHistory table with something like Redis or similar.
      sh = SearchHistory.find_or_create_by(session_key: params[:search_key])
      sh.update!(term: params[:term]) if sh.slug != to_slug(params[:term])
    end
    render json: {}, status: 200
  end

end