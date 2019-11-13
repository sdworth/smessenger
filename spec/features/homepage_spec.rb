RSpec.describe 'Homepage', type: :feature do
  it 'shows a welcome message' do
    visit '/'

    expect(page).to have_content('Welcome to SMessenger!')
  end

  it 'allows users to sign in' do
    visit '/'

    click_button 'sign in'

    fill_in :username, with: '2b'
    fill_in :password, with: 'yorha'

    click_button 'Sign In'

    expect(page).to have_content('Welcome 2b! Click a conversation to view your messages.')
  end
end