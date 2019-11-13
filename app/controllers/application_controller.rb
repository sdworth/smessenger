# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find_by(id: cookies[:user_id])
  end
end
