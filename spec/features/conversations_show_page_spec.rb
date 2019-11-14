# frozen_string_literal: true

RSpec.describe 'Conversations Show Page' do
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }
  let!(:conversation) { create(:conversation_with_users, users: [user_one, user_two]) }
  let!(:message_one) { create(:message, conversation: conversation, user: user_one) }
  let!(:message_two) { create(:message, conversation: conversation, user: user_two) }
  let!(:message_three) { create(:message, conversation: conversation, user: user_one) }

  it 'shows a list of messages in recency order in the conversation' do
    sign_in user_one

    visit conversation_path(conversation)

    within('#messages') do
      expect(page).to have_selector('.message', count: 3)

      within('.message:first-child') do
        expect(page).to have_content(message_one.body)
      end

      within('.message:last-child') do
        expect(page).to have_content(message_three.body)
      end
    end
  end

  it 'lets users add messages to the conversation' do
    sign_in user_one

    visit conversation_path(conversation)

    fill_in :message_body, with: "cause we're gonna shout it loud"

    click_button 'Send Message'

    within('#messages') do
      expect(page).to have_content("cause we're gonna shout it loud")
    end
  end
end
