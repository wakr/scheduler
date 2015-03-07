class AddIsDoneToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :is_done, :boolean
  end
end
