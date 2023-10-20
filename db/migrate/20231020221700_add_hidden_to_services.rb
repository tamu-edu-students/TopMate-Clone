class AddHiddenToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :hidden, :boolean, default: false
  end
end
