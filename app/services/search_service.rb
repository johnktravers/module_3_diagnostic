class SearchService

  def initialize(house)
    @house = house
  end

  def get_order_members
    response = fetch_member_data
    parse_data(response)
  end


  private

  attr_reader :house

  def conn
    Faraday.new(
      url: 'https://www.potterapi.com/v1',
      params: { key: ENV['POTTER_API_KEY'] },
    )
  end

  def fetch_member_data
    conn.get('characters') do |req|
      req.params['house'] = house
      req.params['orderOfThePhoenix'] = true
    end
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
