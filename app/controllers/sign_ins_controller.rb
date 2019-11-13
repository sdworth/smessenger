# frozen_string_literal: true

class SignInsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username], password: params[:password])

    if !user
      redirect_to new_sign_in_path, alert: 'Oops! No match found, please try again.'
      return
    end

    cookies[:user_id] = user.id

    redirect_to conversations_path
  end

  def destroy
    cookies.delete(:user_id)

    redirect_to root_path, notice: 'You have been signed out. Have a nice day!'
  end
end
