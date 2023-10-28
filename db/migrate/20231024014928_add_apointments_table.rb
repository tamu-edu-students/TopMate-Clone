class AddApointmentsTable < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
    CREATE TYPE appointment_status AS ENUM ('booked', 'closed', 'cancelled');
  SQL

    create_table :appointments, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.uuid :service_id
      t.string :fname
      t.string :lname
      t.string :email
      t.timestamp :startdatetime
      t.timestamp :enddatetime
      t.decimal :amount_paid
      t.string :status, default: 'booked', null: false, enum_name: :appointments_status
      t.timestamps
    end
    add_foreign_key :appointments, :services, column: :service_id, primary_key: 'id'
  end
end
