# frozen_string_literal: true

RSpec.describe Conversation do
  context '#build' do
    let(:user_one) { create(:user) }
    let(:user_two) { create(:user) }

    it 'takes in a list of user ids and builds a conversation and supporting user conversations' do
      expect(Conversation.count).to eq(0)
      expect(UserConversation.count).to eq(0)

      conversation = Conversation.build([user_one.id, user_two.id])

      expect(Conversation.count).to eq(1)
      expect(UserConversation.count).to eq(2)

      expect(conversation.user_conversations.map(&:user_id).sort).to eq([user_one.id, user_two.id])
    end

    it 'does creates in a transaction so that nothing is saved if there are errors' do
      allow(UserConversation).to receive(:create!).and_raise

      expect(Conversation.count).to eq(0)
      expect(UserConversation.count).to eq(0)

      try do
        Conversation.build([user_one.id, user_two.id])
      rescue StandardError
      end

      expect(Conversation.count).to eq(0)
      expect(UserConversation.count).to eq(0)
    end
  end

  context '.users_list' do
    let!(:user_one) { create(:user) }
    let!(:user_two) { create(:user) }
    let!(:user_three) { create(:user) }
    let!(:conversation) { create(:conversation_with_users, users: [user_one, user_two, user_three]) }

    it 'returns a comma separated list of username in the conversation excluding the current user' do
      expect(conversation.user_list(user_one)).to eq("#{user_two.username}, #{user_three.username}")
    end
  end
end
