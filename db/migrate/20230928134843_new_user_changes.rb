class NewUserChanges < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'
    rename_column :users, :name, :fname
    change_column_null :users, :fname, false
    add_column :users, :lname, :string, default: "", null: false
    add_column :users, :user_id, :uuid, default: -> { "uuid_generate_v4()" }, null: false
  end
end
