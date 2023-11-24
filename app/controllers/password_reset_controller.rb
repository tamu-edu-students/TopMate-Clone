# frozen_string_literal: true

class PasswordResetController < ApplicationController
  def change_password
    sessionToken = ResetPasswordSession.find_by(session_token: params[:token])
    if sessionToken
      user = User.find(sessionToken.user_id)
      user.password = params[:password]
      user.save
      flash[:success] = 'Password changed'
      sessionToken.destroy
    else
      flash[:error] = 'Reset session does not exist'
    end
    redirect_to root_path
  end
end
