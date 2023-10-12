class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services, id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid :user_id, null: false
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :duration
      t.boolean :is_published, default: false
      t.timestamps
    end

    add_foreign_key :services, :users, column: :user_id, primary_key: "user_id"
  end
end
