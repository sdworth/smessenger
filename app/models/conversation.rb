# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :user_conversations
  has_many :users, through: :user_conversations
  has_many :messages

  def self.build(user_ids)
    transaction do
      conversation = create!

      user_ids.each do |user_id|
        UserConversation.create!(user_id: user_id, conversation_id: conversation.id)
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

  def user_is_participant?(user)
    users.include?(user)
  end
end
