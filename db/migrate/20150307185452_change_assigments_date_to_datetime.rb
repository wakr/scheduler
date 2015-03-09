class ChangeAssigmentsDateToDatetime < ActiveRecord::Migration
  def change
    change_column :assignments, :deadline, :datetime
  end
end
