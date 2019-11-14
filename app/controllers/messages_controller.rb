# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    Message.create!(conversation: conversation, user: current_user, body: params[:message][:body])

    redirect_to conversation_path(conversation)
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:conversation_id])
  end
end
