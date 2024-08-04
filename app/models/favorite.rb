class Favorite < ApplicationRecord
  belongs_to :user

  validates :comic_id, :title, :image_url, presence: true
end
