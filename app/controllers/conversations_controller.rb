# frozen_string_literal: true

class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations
    @conversation = Conversation.new
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  def create
    usernames = params[:conversation][:usernames].split(/, |,/)
    user_ids = User.where(username: usernames).pluck(:id)

    if user_ids.length < usernames.length
      redirect_to conversations_path, alert: username_mismatch
      return
    end

    user_ids << current_user.id

    conversation = Conversation.build(user_ids)

    redirect_to conversation_path(conversation)
  end

  private

  def username_mismatch
    "We couldn't find matches for all the usernames you specified and so your conversation was not created."
  end
end
