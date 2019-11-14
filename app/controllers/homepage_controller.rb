# frozen_string_literal: true

class HomepageController < ApplicationController
  def show
    redirect_to conversations_path if current_user
  end
end
