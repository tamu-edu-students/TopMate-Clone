# frozen_string_literal: true

class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user].signed_id(expires_in: 15.minutes, purpose: 'password_reset')
    @reset_password_session=ResetPasswordSession.find_by(user_id: params[:user].user_id)
    if @reset_password_session
      @token = @reset_password_session.session_token
    end
    mail to: params[:user].email, subject: 'Reset your password'
  end
end
