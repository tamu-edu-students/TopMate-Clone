

require 'rails_helper'

RSpec.describe PasswordMailer, type: :mailer do
  describe 'reset' do
    let(:user) { User.create(fname: 'user1_fname', lname: 'user1_lname', email: 'user@example.com', password: 'password1', about: 'abcd' ) }
    let(:mail) { PasswordMailer.with(user: user).reset }

    it 'renders the headers' do
      expect(mail.subject).to eq('Reset your password')
      expect(mail.to).to eq(['user@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/reset\/(.+)--[a-f0-9]+/)
    end
  end
end
