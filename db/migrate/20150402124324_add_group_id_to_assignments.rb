class AddGroupIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :group_id, :integer
  end
end
