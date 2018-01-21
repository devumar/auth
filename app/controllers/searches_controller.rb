class SearchesController < ApplicationController
  before_action :set_auth

  def new
    @search = Search.new
    if request.post?
      @search_terms = params[:search][:title]
      youtube_service = YoutubeService.new(@search_terms)
      @res = youtube_service.main
    end
  end

  private
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
