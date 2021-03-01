class SearchHistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token # Todo: Enable this for prod to avoid attacks and send CSRF token in req.

  include SearchesHelper

  def create
    if params[:term] && params[:search_key]
      # Todo, Replace SearchHistory table with something like Redis or similar.
      sh = SearchHistory.find_or_create_by(session_key: params[:search_key])
      sh.update(term: params[:term]) if sh.slug != to_slug(params[:term])
    end
    render json: sh, status: 200
  end

  def update
    if params[:id]
      sh = SearchHistory.find_by_session_key(params[:id])
      if sh
        sh.completed!
      end
    end
    redirect_to :root
  end

end