# frozen_string_literal: true

module Features
  module SignInHelpers
    def sign_in(user)
      visit '/'

      click_button 'sign in'

      fill_in :username, with: user.username
      fill_in :password, with: user.password

      click_button 'Sign In'
    end
  end
end
