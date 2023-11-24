# frozen_string_literal: true

# spec/controllers/email_submission_controller_spec.rb

require 'rails_helper'

RSpec.describe EmailSubmissionController, type: :controller do
  describe 'POST #send_email' do
    let(:email) { 'test@example.com' }

    context 'when email is associated with a user' do
      before do
        allow(controller).to receive(:isEmailAssociated).with(email).and_return(true)
        post :send_email, params: { "Email Address": email }
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Email to reset password has been sent!')
      end

      it 'redirects back to the previous location' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when email is not associated with any user' do
      before do
        allow(controller).to receive(:isEmailAssociated).with(email).and_return(false)
        post :send_email, params: { "Email Address": email }
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('This email is not associated with any user')
      end

      it 'redirects back to the previous location' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#isEmailAssociated' do
    let(:email) { 'test@example.com' }
    let(:user) { create(:user, email: email) }

    context 'when email is associated with a user' do
      before do
        allow(User).to receive(:exists?).with(email: email).and_return(true)
        allow(User).to receive(:find_by).with(email: email).and_return(user)
        allow(PasswordMailer).to receive_message_chain(:with, :reset, :deliver_later)
        allow_any_instance_of(EmailSubmissionController).to receive(:generateResetSession)
      end

      it 'sends a password reset email' do
        expect(PasswordMailer).to receive_message_chain(:with, :reset, :deliver_later)
        subject.isEmailAssociated(email)
      end

      it 'generates a reset session' do
        expect(subject).to receive(:generateResetSession).with(user)
        subject.isEmailAssociated(email)
      end

      it 'returns true' do
        expect(subject.isEmailAssociated(email)).to be true
      end
    end

    context 'when email is not associated with any user' do
      before do
        allow(User).to receive(:exists?).with(email: email).and_return(false)
      end

      it 'returns false' do
        expect(subject.isEmailAssociated(email)).to be false
      end
    end
  end

  describe '#generateResetSession' do
    let(:user) { create(:user) }

    it 'creates a reset password session for the user' do
      expect {
        subject.generateResetSession(user)
      }.to change(ResetPasswordSession, :count).by(1)
    end

    it 'returns the generated session token' do
      session_token = subject.generateResetSession(user)
      expect(session_token).to be_a(String)
      expect(session_token).not_to be_empty
    end
  end
end
