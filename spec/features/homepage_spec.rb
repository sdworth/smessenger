# frozen_string_literal: true

RSpec.describe 'Homepage' do
  let(:user) { create(:user) }

  it 'shows a welcome message' do
    visit '/'

    expect(page).to have_content('Welcome to SMessenger!')
  end

  it 'allows users to sign in' do
    visit '/'

    click_button 'sign in'

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Sign In'

    expect(page).to have_content("Welcome #{user.username}! Click a conversation to view your messages.")
  end

  context 'with bad credentials' do
    it 'does not let users sign in' do
      visit '/'

      click_button 'sign in'

      fill_in :username, with: 'evil user'
      fill_in :password, with: 'evil password'

      click_button 'Sign In'

      expect(page).to have_content('Oops! No match found, please try again.')
    end
  end
end
