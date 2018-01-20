class SearchesController < ApplicationController
  def create
    @search_terms = params[:search][:title]
    youtube_service = YoutubeService.new(@search_terms)
    @res = youtube_service.main
    puts @res
    redirect_to searches_path

  end
 def new
   @search = Search.new
end
def index
  @res = @res
  puts @res
end
end
