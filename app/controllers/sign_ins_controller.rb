class SignInsController < ApplicationController
  def new; end

  def create
    redirect_to conversations_path
  end
end