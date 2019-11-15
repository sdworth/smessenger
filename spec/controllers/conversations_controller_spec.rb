# frozen_string_literal: true

RSpec.describe ConversationsController do
  context '#show' do
    let(:user) { create(:user) }
    let(:conversation) { create(:conversation) }

    before do
      allow_any_instance_of(ConversationsController).to receive(:current_user).and_return(user)
    end

    it "only lets users see conversations that they're participating in" do
      get :show, params: { id: conversation.id }

      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq("That's not your conversation!")
    end
  end

  context '#create' do
    let(:user_one) { create(:user) }
    let(:user_two) { create(:user) }
    let(:user_three) { create(:user) }
    let(:user_four) { create(:user) }
    let(:usernames) do
      [
        user_two.username,
        user_three.username,
        user_four.username
      ]
    end

    before do
      allow_any_instance_of(ConversationsController).to receive(:current_user).and_return(user_one)
    end

    it 'builds a conversation, given a list of user ids' do
      expected_ids = [user_two.id, user_three.id, user_four.id, user_one.id]

      expect(Conversation).to receive(:build).with(expected_ids).and_call_original

      expect do
        post :create, params: { conversation: { usernames: usernames } }
      end.to change { Conversation.count }.by(1)
    end

    it 'returns an error if a username is not found' do
      post :create, params: { conversation: { usernames: ['a2'] } }

      expect(response).to redirect_to(conversations_path)
      expect(flash[:alert]).to eq(
        "We couldn't find matches for all the usernames you specified and so your conversation was not created."
      )
    end
  end
end
