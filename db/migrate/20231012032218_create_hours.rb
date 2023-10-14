# frozen_string_literal: true

class CreateHours < ActiveRecord::Migration[7.0]
  def change
    create_table :hours, id: :uuid, default: -> { 'uuid_generate_v4()' }, force: :cascade do |t|
      t.uuid :user_id
      t.integer :day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end

    add_foreign_key :hours, :users, column: :user_id, primary_key: 'user_id'
  end
end
