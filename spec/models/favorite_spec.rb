require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { User.create!(email: 'user@user.com', password: '123456') }

  it { should belong_to(:user) }

  it { should validate_presence_of(:comic_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:image_url) }

  context 'with valid attributes' do
    it 'is valid with valid attributes' do
      favorite = Favorite.new(
        comic_id: 1,
        title: 'Spider-Man',
        image_url: 'https://example.com/spider-man.jpg',
        user:
      )
      expect(favorite).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'is not valid without a comic_id' do
      favorite = Favorite.new(
        title: 'Spider-Man',
        image_url: 'https://example.com/spider-man.jpg',
        user:
      )
      expect(favorite).not_to be_valid
      expect(favorite.errors[:comic_id]).to include("can't be blank")
    end
  end
end
