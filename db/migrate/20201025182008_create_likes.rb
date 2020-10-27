class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id, index: true
      t.integer :opinion_id

      t.timestamps
    end

    add_foreign_key :likes, :users, column: :user_id
  end
end
