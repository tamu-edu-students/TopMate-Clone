# frozen_string_literal: true

class PasswordMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    @user = params[:user].signed_id(expires_in: 15.minutes, purpose: 'password_reset')

    if ResetPasswordSession.find_by(user_id: params[:user].id)
      @token = ResetPasswordSession.find_by(user_id: params[:user].id).session_token
    end
    

    mail to: params[:user].email, subject: 'Reset your password'
  end
end
