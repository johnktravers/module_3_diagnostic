class SearchFacade
  attr_reader :house

  def initialize(house)
    @house = house
  end

  def members
    raw_member_data = get_member_data
    create_members(raw_member_data)
  end

  def member_count
    members.length
  end

  def plural_member
    'Member'.pluralize(member_count)
  end


  private

  def service
    SearchService.new(house)
  end

  def get_member_data
    @raw_member_data ||= service.get_order_members
  end

  def create_members(raw_member_data)
    raw_member_data.map { |member_data| Member.new(member_data) }
  end

end
