require 'rails_helper'

RSpec.describe 'Order of the Phoenix Member Search' do

  it 'shows 21 members and their info if Gryffindor is selected' do
    visit root_path

    select 'Gryffindor', from: :house
    click_button 'Search for Members'

    expect(current_path).to eq(search_path)
    expect(page).to have_content('21 Order of the Phoenix Members in House Gryffindor')

    expect(page).to have_css('.member', count: 21)

    within(first('.member')) do
      expect(first('.name').text).to_not be_empty
      expect(first('.house').text).to eq('Gryffindor')
      expect(page).to have_css('.role')
      expect(page).to have_css('.patronus')
    end
  end

end
