class SearchFacade
  attr_reader :house

  def initialize(house)
    @house = house
  end

  def members
    conn = Faraday.new(
      url: 'https://www.potterapi.com/v1',
      params: { key: ENV['POTTER_API_KEY'] },
    )

    response = conn.get('characters') do |req|
      req.params['house'] = house
      req.params['orderOfThePhoenix'] = true
    end

    raw_member_data = JSON.parse(response.body, symbolize_names: true)

    raw_member_data.map do |member_data|
      Member.new(member_data)
    end
  end

  def member_count
    members.length
  end

end
