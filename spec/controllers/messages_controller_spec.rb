# frozen_string_literal: true

RSpec.describe MessagesController do
  context '#create' do
    let(:user) { create(:user) }
    let(:conversation) { create(:conversation_with_users, users: [user], updated_at: Time.at(0)) }

    before do
      allow_any_instance_of(MessagesController).to receive(:current_user).and_return(user)
    end

    it 'makes a message for the given conversation' do
      expect do
        post :create, params: {
          conversation_id: conversation.id,
          message: { body: 'even if our words seem meaningless' }
        }
      end.to change { Message.count }.by(1)
    end

    it 'updates the conversation timestamp to reflect that it has a new message' do
      old_timestamp = conversation.updated_at.to_i

      post :create, params: {
        conversation_id: conversation.id,
        message: { body: 'even if our words seem meaningless' }
      }

      new_timestamp = conversation.reload.updated_at.to_i

      expect(new_timestamp).to be > old_timestamp
    end
  end
end
