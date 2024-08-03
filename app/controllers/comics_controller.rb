class ComicsController < ApplicationController
  def index
    @comics = MarvelService.new.fetch_comics
  end

  def search
    @comics = MarvelService.new(comics_params[:character_name]).fetch_comics_by_character

    render :index
  end

  private

  def comics_params
    params.permit(:character_name)
  end
end
