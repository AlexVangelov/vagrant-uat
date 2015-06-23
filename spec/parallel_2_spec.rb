describe 'UAT', type: :feature do

  it "Parallel 2" do
    visit 'https://en.wikipedia.org'
    
    within '#simpleSearch' do
      fill_in 'search', with: 'UAT'
      click_on 'Go'
    end
    
    within '#bodyContent' do
      expect(page).to have_selector 'a', text: 'User acceptance testing'
      click_on 'User acceptance testing'
    end
    
    expect(page).to have_content 'verifying that a solution works for the user'
  end
end
