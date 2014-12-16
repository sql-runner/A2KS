class SearchesController < ApplicationController
  def show
    @videos = Video.search_results(params[:search])
  end
end
