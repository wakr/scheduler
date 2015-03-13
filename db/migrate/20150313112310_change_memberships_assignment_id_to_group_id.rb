class ChangeMembershipsAssignmentIdToGroupId < ActiveRecord::Migration
  def change
    rename_column :memberships, :assignment_id, :group_id
  end
end
