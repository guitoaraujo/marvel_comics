class MarvelService
  include HTTParty
  base_uri 'https://gateway.marvel.com/v1/public'

  def initialize
    @private_key = ENV.fetch('MARVEL_PRIVATE_KEY', nil)
    @public_key = ENV.fetch('MARVEL_PUBLIC_KEY', nil)
  end

  def fetch_comics(offset: 0, limit: 20)
    query = build_query(limit:, offset:)
    # response = self.class.get('/comics', query: query)

    # MOCK
    {
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
    }
  end

  def fetch_comics_by_character(character_name:, offset: 0, limit: 20)
    character = fetch_character_by_name(character_name)
    return { results: [] } unless character

    query = build_query(limit:, offset:)
    # response = self.class.get("/characters/#{character[:id]}/comics", query: query)

    # MOCK
    {
      results: [
        {
          id: 1,
          title: 'X-Force (2024) #1',
          image_url: 'https://cdn.marvel.com/u/prod/marvel/i/mg/3/a0/66212b6b44f79/clean.jpg'
        }
      ]
    }
  end

  private

  def fetch_character_by_name(name)
    query = build_query(name:)
    # response = self.class.get('/characters/', query: query)
    # Assume the character fetching logic is implemented here

    # MOCK
    { id: 123, name: 'Deadpool' }
  end

  def build_query(name: nil, limit: 20, offset: 0)
    ts = DateTime.now.to_i
    hash = Digest::MD5.hexdigest("#{ts}#{@private_key}#{@public_key}")

    {
      apikey: @public_key,
      ts:,
      hash:,
      limit:,
      offset:,
      name:
    }.compact
  end
end
