class CreateResetPasswordSessions < ActiveRecord::Migration[7.0]
  def change
    create_table 'reset_password_sessions' do |t|
      t.uuid 'user_id'
      t.string 'session_token'
      t.timestamps
    end
  end
end
