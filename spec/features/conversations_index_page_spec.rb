# frozen_string_literal: true

RSpec.describe 'Conversations Index Page' do
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:user_three) { create(:user) }
  let!(:conversation_one) { create(:conversation_with_users, users: [user_one, user_two]) }
  let!(:conversation_two) { create(:conversation_with_users, users: [user_one, user_three]) }
  let!(:message) { create(:message, conversation: conversation_one) }

  it "shows a list of the user's messages" do
    sign_in user_one

    within('#conversations') do
      expect(page).to have_selector('.conversation', count: 2)

      expect(page).to have_content(user_two.username)
      expect(page).to have_content(user_three.username)
    end
  end

  it 'allows users to view their conversations' do
    sign_in user_one

    click_link user_two.username

    expect(page).to have_content message.body
  end
end
