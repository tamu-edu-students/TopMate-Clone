# frozen_string_literal: true

class AddShortDescriptionToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :short_description, :text
  end
end
