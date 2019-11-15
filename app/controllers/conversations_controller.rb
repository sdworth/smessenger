# frozen_string_literal: true

class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.includes(:users).order(updated_at: :desc)
    @conversation = Conversation.new
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new

    redirect_to root_path, alert: "That's not your conversation!" if !@conversation.user_is_participant?(current_user)
  end

  def create
    usernames = parse_usernames
    user_ids = convert_usernames_to_ids(usernames)

    if usernames.empty? || user_ids.length < usernames.length
      redirect_to conversations_path, alert: username_mismatch
      return
    end

    conversation = build_conversation_with_current_user(user_ids)

    redirect_to conversation_path(conversation)
  end

  private

  def parse_usernames
    params[:conversation][:usernames].split(/, |,/)
  end

  def convert_usernames_to_ids(usernames)
    User.where(username: usernames).pluck(:id)
  end

  def username_mismatch
    "We couldn't find matches for all the usernames you specified and so your conversation was not created."
  end

  def build_conversation_with_current_user(user_ids)
    Conversation.build(user_ids + [current_user.id])
  end
end
