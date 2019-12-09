class Member
  attr_reader :name, :role, :house, :patronus

  def initialize(member_data)
    @name = member_data[:name]
    @role = member_data[:role] || 'Unknown'
    @house = member_data[:house]
    @patronus = member_data[:patronus] || 'Unknown'
  end

end
