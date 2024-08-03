class ComicsController < ApplicationController
  before_action :set_marvel_service, only: %i[index search]
  before_action :set_favorites, only: %i[index search]

  def index
    @comics = @marvel_service.fetch_comics
  end

  def search
    @comics = @marvel_service.fetch_comics_by_character(character_name: comics_params[:character_name])

    render :index
  end

  def add_favorite
    comic_params = comics_params[:comic]
    comic = build_comic_from_params(comic_params)
    FavoriteService.new.add_favorite(comic, current_user)

    redirect_to comics_path
  end

  def remove_favorite
    FavoriteService.new.remove_favorite(params[:id])

    redirect_to comics_path
  end

  private

  def set_marvel_service
    @marvel_service = MarvelService.new
  end

  def set_favorites
    @favorites = Favorite.all
  end

  def comics_params
    params.permit(:character_name, comic: %i[id title image_url])
  end

  def build_comic_from_params(params)
    OpenStruct.new(params.to_h)
  end
end
