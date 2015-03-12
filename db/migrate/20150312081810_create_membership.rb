class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :assignment_id
    end
  end
end
