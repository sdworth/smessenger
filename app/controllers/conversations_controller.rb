# frozen_string_literal: true

class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations
  end
end
