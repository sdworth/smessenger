# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    message = Message.create!(conversation: conversation, user: current_user, body: params[:message][:body])

    conversation.touch

    MessageChannel.broadcast_to(conversation, message.as_json.merge(username: current_user.username))

    redirect_to conversation_path(conversation)
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:conversation_id])
  end
end
