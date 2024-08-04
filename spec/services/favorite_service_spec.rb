require 'rails_helper'

RSpec.describe FavoriteService, type: :service do
  let(:user) { User.create!(email: 'user@user.com', password: '123456') }
  let(:comic) { double('Comic', id: 1, title: 'Spider-Man', image_url: 'https://example.com/spider-man.jpg') }
  let(:service) { described_class.new }

  describe '#add_favorite' do
    it 'creates a favorite with valid attributes' do
      expect do
        service.add_favorite(comic, user)
      end.to change { Favorite.count }.by(1)

      favorite = Favorite.last
      expect(favorite.comic_id).to eq(comic.id)
      expect(favorite.title).to eq(comic.title)
      expect(favorite.image_url).to eq(comic.image_url)
      expect(favorite.user).to eq(user)
    end

    it 'raises an error if the favorite cannot be created' do
      allow(Favorite).to receive(:create!).and_raise(ActiveRecord::RecordInvalid.new(Favorite.new))

      expect do
        service.add_favorite(comic, user)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#remove_favorite' do
    let!(:favorite) { Favorite.create!(comic_id: comic.id, title: comic.title, image_url: comic.image_url, user:) }

    it 'removes a favorite by id' do
      expect do
        service.remove_favorite(favorite.id)
      end.to change { Favorite.count }.by(-1)
    end

    it 'raises an error if the favorite cannot be found' do
      expect do
        service.remove_favorite(999)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
