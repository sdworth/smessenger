# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :user_conversations
  has_many :users, through: :user_conversations

  def self.build(users)
    transaction do
      conversation = create!

      users.each do |user|
        UserConversation.create!(user_id: user.id, conversation_id: conversation.id)
      end

      conversation
    end
  end

  def user_list(current_user)
    users
      .filter { |user| user != current_user }
      .map(&:username)
      .join(', ')
  end
end
