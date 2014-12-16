class SearchesController < ApplicationController
  def show
    @search_results = (Video.where(params[:search]))
  end
end
