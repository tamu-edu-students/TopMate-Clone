# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordMailer, type: :mailer do
  describe 'reset' do
    let(:user) do
      User.create(fname: 'user1_fname', lname: 'user1_lname', email: 'user@example.com', password: 'password1',
                  about: 'abcd')
    end
    let(:mail) { PasswordMailer.with(user:).reset }

    it 'renders the headers' do
      expect(mail.subject).to eq('Reset your password')
      expect(mail.to).to eq(['user@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(%r{reset/(\s*|[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12})})
    end
  end
end
