class UserIdAsPk < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE users DROP CONSTRAINT users_pkey"
    execute "ALTER TABLE users ADD PRIMARY KEY(user_id)"
    remove_column :users, :id
  end
end
