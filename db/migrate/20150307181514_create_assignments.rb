class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.integer :user_id
      t.boolean :is_done
      t.date :deadline

      t.timestamps null: false
    end
  end
end
