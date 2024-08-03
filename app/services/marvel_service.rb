class MarvelService
  include HTTParty
  base_uri 'https://gateway.marvel.com/v1/public'

  def initialize(offset = 0, limit = 20, character_name = nil)
    @offset = offset
    @limit = limit
    @character_name = character_name
    @private_key = ENV.fetch('MARVEL_PRIVATE_KEY', nil)
    @public_key = ENV.fetch('MARVEL_PUBLIC_KEY', nil)
    @ts = DateTime.now.to_i
    @hash = Digest::MD5.hexdigest("#{@ts}#{@private_key}#{@public_key}")
  end

  def fetch_comics
    query = {
      limit: @limit,
      offset: @offset,
      orderBy: '-onsaleDate',
      apikey: @public_key,
      ts: @ts,
      hash: @hash
    }
    # self.class.get('/comics', query:)

    # MOCK
    {
      results: [
        {
          title: 'X-Force (2024) #1',
          image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/3/a0/66212b6b44f79/clean.jpg'
        },
        {
          title: 'X-Force (2024) #2',
          image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/e/f0/664cced10ba8c/clean.jpg'
        },
        {
          title: 'X-Force (2024) #3',
          image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/e/40/6669b76805624/clean.jpg'
        }
      ]
    }
  end

  def fetch_comics_by_character
    characters_query = {
      name: @character_name,
      apikey: @public_key,
      ts: @ts,
      hash: @hash
    }
    # self.class.get('/characters/', query: characters_query)

    # MOCK
    character = {
      id: 123,
      name: 'Deadpool'
    }

    comics_query = {
      limit: @limit,
      offset: @offset,
      orderBy: '-onsaleDate',
      apikey: @public_key,
      ts: @ts,
      hash: @hash
    }

    # self.class.get("/characters/#{character[:id]}/comics", query: comics_query)

    # MOCK
    {
      results: [
        {
          title: 'X-Force (2024) #1',
          image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/3/a0/66212b6b44f79/clean.jpg'
        }
      ]
    }
  end
end
