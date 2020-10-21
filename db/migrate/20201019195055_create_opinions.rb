# frozen_string_literal: true

class CreateOpinions < ActiveRecord::Migration[6.0]
  def change
    create_table :opinions do |t|
      t.text :text

      t.timestamps
    end
  end
end
