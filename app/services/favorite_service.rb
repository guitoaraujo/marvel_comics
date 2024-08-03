class FavoriteService
  def add_favorite(comic, user)
    Favorite.create!(comic_id: comic.id, title: comic.title, image_url: comic.image_url, user:)
  end

  def remove_favorite(id)
    favorite = Favorite.find(id)
    favorite.destroy
  end
end
