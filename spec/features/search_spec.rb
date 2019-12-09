require 'rails_helper'

RSpec.describe 'Order of the Phoenix Member Search' do

  it 'shows 21 members and their info if Gryffindor is selected' do
    VCR.use_cassette('gryffindor_members') do
      visit root_path

      select 'Gryffindor', from: :house
      click_button 'Search For Members'

      expect(current_path).to eq(search_path)
      expect(page).to have_content('21 Members in House Gryffindor')

      expect(page).to have_css('.member', count: 21)

      within(first('.member')) do
        expect(first('.name').text).to_not be_empty
        expect(first('.house').text).to eq('House: Gryffindor')
        expect(page).to have_css('.role')
        expect(page).to have_css('.patronus')
      end
    end
  end

  it 'shows 1 member and his info if Slytherin is selected' do
    VCR.use_cassette('slytherin_members') do
      visit root_path

      select 'Slytherin', from: :house
      click_button 'Search For Members'

      expect(current_path).to eq(search_path)
      expect(page).to have_content('1 Member in House Slytherin')

      within('.member') do
        within('.name')  { expect(page).to have_content('Severus Snape') }
        within('.house') { expect(page).to have_content('Slytherin') }
        within('.role')  { expect(page).to have_content('Professor, Potions') }
        within('.patronus') { expect(page).to have_content('doe') }
      end
    end
  end

end
