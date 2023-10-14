# frozen_string_literal: true

class PasswordResetController < ApplicationController
  def change_password
    # puts "resetting password for token #{params[:token]}"

    sessionToken = ResetPasswordSession.find_by(session_token: params[:token])
    if sessionToken
      # Reset password logic
      # puts "retrieved session token id is #{sessionToken.id}"
      # puts sessionToken.inspect

      user = User.find(sessionToken.user_id)
      # puts user.inspect
      # puts "retrieved user name is #{user.fname}"
      user.password = params[:password]

      user.save

      flash[:success] = 'Password changed'
      sessionToken.destroy
      # puts "session deleted"

    else
      # puts "session not found for token #{params[:token]}"

      flash[:error] = 'Reset session does not exist'
    end
    redirect_to root_path
  end
end
