# frozen_string_literal: true

RSpec.describe PasswordResetController, type: :controller do
  describe '#change_password' do
    let(:user) { create(:user) }
    let(:reset_password_session) { create(:reset_password_session, user_id: user.user_id) }
    # let(:user) { reset_password_session.user }

    context 'when session token exists' do
      before do
        post :change_password, params: { token: reset_password_session.session_token, password: 'new_password' }
      end

      it 'changes the user password' do
        user.reload
        expect(user.authenticate('new_password')).to be_truthy
      end

      it 'destroys the reset password session' do
        expect(ResetPasswordSession.find_by(session_token: reset_password_session.session_token)).to be_nil
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to eq('Password changed')
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when session token does not exist' do
      before do
        post :change_password, params: { token: 'invalid_token', password: 'new_password' }
      end

      it 'does not change the user password' do
        user.reload
        expect(user.authenticate('new_password')).to be_falsey
      end

      it 'does not destroy any reset password session' do
        expect(ResetPasswordSession.find_by(session_token: reset_password_session.session_token)).to be_present
      end

      it 'sets the flash error message' do
        expect(flash[:error]).to eq('Reset session does not exist')
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
