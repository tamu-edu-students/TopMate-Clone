# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordMailer, type: :mailer do
  describe '#reset' do
    let(:user) { create(:user) }
    let(:token) {SecureRandom.uuid}
    let(:reset_password_session) { create(:reset_password_session, session_token: token, user_id: user.user_id) }
    let(:mail) { PasswordMailer.with(user:).reset.deliver_now }

    before do
      allow(ResetPasswordSession).to receive(:find_by).with(user_id: user.id).and_return(reset_password_session)
    end

    it 'sends an email with the correct subject' do
      expect(mail.subject).to eq('Reset your password')
    end

    it 'sends an email to the user' do
      expect(mail.to).to eq([user.email])
    end

    it 'assigns the user ID as a signed ID' do
      expect(mail.body.encoded).to include(token)
    end

    it 'assigns the session token' do
      expect(mail.body.encoded).to include(reset_password_session.session_token)
    end

    context 'when a reset password session does not exist for the user' do
      before do
        allow(ResetPasswordSession).to receive(:find_by).with(user_id: user.id).and_return(nil)
      end

      it 'does not assign the session token' do
        expect(mail.body.encoded).not_to include('session_token')
      end
    end
  end
end
