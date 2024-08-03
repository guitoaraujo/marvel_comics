class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.integer :comic_id, null: false
      t.string :title, null: false
      t.string :image_url, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
