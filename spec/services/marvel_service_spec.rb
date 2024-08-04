require 'rails_helper'
require 'webmock/rspec'

RSpec.describe MarvelService, type: :service do
  let(:service) { described_class.new }
  let(:public_key) { 'public_key' }
  let(:private_key) { 'private_key' }
  let(:ts) { DateTime.now.to_i }
  let(:hash) { Digest::MD5.hexdigest("#{ts}#{private_key}#{public_key}") }

  before do
    allow(ENV).to receive(:fetch).with('MARVEL_PUBLIC_KEY', nil).and_return(public_key)
    allow(ENV).to receive(:fetch).with('MARVEL_PRIVATE_KEY', nil).and_return(private_key)
  end

  describe '#fetch_comics' do
    it 'returns a list of comics' do
      stub_request(:get, %r{https://gateway.marvel.com/v1/public/comics})
        .with(query: hash_including(apikey: public_key, ts: ts.to_s))
        .to_return(status: 200, body: {
          results: [
            {
              id: 1,
              title: 'X-Force (2024) #1',
              image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/3/a0/66212b6b44f79/clean.jpg'
            },
            {
              id: 2,
              title: 'X-Force (2024) #2',
              image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/e/f0/664cced10ba8c/clean.jpg'
            },
            {
              id: 3,
              title: 'X-Force (2024) #3',
              image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/e/40/6669b76805624/clean.jpg'
            }
          ]
        }.to_json)

      response = service.fetch_comics
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['results'].size).to eq(3)
      expect(parsed_response['results'].first['title']).to eq('X-Force (2024) #1')
    end
  end

  describe '#fetch_comics_by_character' do
    it 'returns a list of comics for a given character' do
      stub_request(:get, %r{https://gateway.marvel.com/v1/public/characters})
        .to_return(status: 200, body: { 'results' => [{ 'id' => 123, 'name' => 'Deadpool' }] }.to_json)

      stub_request(:get, %r{https://gateway.marvel.com/v1/public/characters/*})
        .to_return(status: 200, body: {
          'results' => [
            {
              'id' => 1,
              'title' => 'X-Force (2024) #1',
              'image_url' => 'https://cdn.marvel.com/u/prod/marvel/i/mg/3/a0/66212b6b44f79/clean.jpg'
            }
          ]
        }.to_json)

      response = service.fetch_comics_by_character(character_name: 'Deadpool')
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['results'].size).to eq(1)
      expect(parsed_response['results'].first['title']).to eq('X-Force (2024) #1')
    end

    it 'returns an empty list if character is not found' do
      stub_request(:get, %r{https://gateway.marvel.com/v1/public/characters})
        .to_return(status: 200, body: { 'results' => [] }.to_json)

      response = service.fetch_comics_by_character(character_name: 'Nonexistent Character')
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['results']).to be_empty
    end
  end

  describe '#fetch_character_by_name' do
    it 'returns character information' do
      stub_request(:get, %r{https://gateway.marvel.com/v1/public/characters})
        .to_return(status: 200, body: { 'results' => [{ 'id' => 123, 'name' => 'Deadpool' }] }.to_json)

      response = service.send(:fetch_character_by_name, 'Deadpool')
      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to eq('results' => [{ 'id' => 123, 'name' => 'Deadpool' }])
    end

    it 'returns empty object if character is not found' do
      stub_request(:get, %r{https://gateway.marvel.com/v1/public/characters})
        .to_return(status: 200, body: {}.to_json)

      response = service.send(:fetch_character_by_name, 'Nonexistent Character')
      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to eq({})
    end
  end
end
