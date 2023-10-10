class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.uuid :user_id
      t.timestamps
    end

    add_foreign_key :services, :users, column: :user_id, primary_key: "user_id"
  end
end