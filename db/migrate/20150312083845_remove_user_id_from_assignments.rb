class RemoveUserIdFromAssignments < ActiveRecord::Migration
  def change
    Assignment.all.each do |assignment|
      Membership.create user_id:assignment.user_id, assignment_id:assignment.id
    end

    remove_column :assignments, :user_id, :integer
  end
end
