class ComicsController < ApplicationController
  def index
    @comics = MarvelService.new.fetch_comics
    @favorites = Favorite.all
  end

  def search
    @comics = MarvelService.new(comics_params[:character_name]).fetch_comics_by_character
    @favorites = Favorite.all

    render :index
  end

  def add_favorite
    comic = comics_params[:comic]
    Favorite.create(comic_id: comic[:id], title: comic[:title], image_url: comic[:image_url], user: current_user)

    redirect_to comics_path
  end

  def remove_favorite
    favorite = Favorite.find(params[:id])
    favorite.destroy

    redirect_to comics_path
  end

  private

  def comics_params
    params.permit(:character_name, comic: %i[id title image_url])
  end
end
