# frozen_string_literal: true

# spec/controllers/email_submission_controller_spec.rb

require 'rails_helper'

RSpec.describe EmailSubmissionController, type: :controller do
  before do
    @request.env['HTTP_REFERER'] = 'http://example.com/previous_page'

    @request.host = 'example.com'
  end

  describe 'POST #send_email' do
    context 'when the email is associated with a user' do
      let(:user) { create(:user, email: 'test@example.com') }

      it 'redirects back to the previous page' do
        post :send_email, params: { "Email Address": 'test@example.com' }
        expect(response).to redirect_to('http://example.com/previous_page')
      end
    end

    context 'when the email is not associated with any user' do
      it 'displays an error message' do
        post :send_email, params: { "Email Address": 'nonexistent@example.com' }
        expect(flash[:error]).to eq('This email is not associated with any user')
      end

      it 'redirects back to the previous page' do
        post :send_email, params: { "Email Address": 'nonexistent@example.com' }
        expect(response).to redirect_to('http://example.com/previous_page')
      end
    end
  end
end
