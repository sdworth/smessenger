# frozen_string_literal: true

RSpec.describe 'Conversations Index Page' do
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:user_three) { create(:user) }
  let!(:conversation_one) { create(:conversation_with_users, users: [user_one, user_two]) }
  let!(:conversation_two) { create(:conversation_with_users, users: [user_one, user_three]) }
  let!(:message) { create(:message, conversation: conversation_one, user: user_one) }

  before do
    sign_in user_one

    visit conversations_path
  end

  it "shows a list of the user's conversations" do
    within('#conversations') do
      expect(page).to have_selector('.conversation', count: 2)

      expect(page).to have_content(user_two.username)
      expect(page).to have_content(user_three.username)
    end
  end

  it 'allows users to view the contents of a conversation' do
    click_link user_two.username

    expect(page).to have_content message.body
  end

  context 'creating a new conversation' do
    let!(:user_four) { create(:user) }

    it 'allows users to create a new conversation' do
      fill_in :conversation_usernames, with: user_four.username

      click_button 'Start Conversation'

      expect(page).to have_content("Conversation with: #{user_four.username}")
    end
  end
end
