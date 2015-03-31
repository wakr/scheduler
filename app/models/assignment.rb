class Assignment < ActiveRecord::Base
  has_many :user_assignments, dependent: :destroy #fix name
  has_many :doers, :through => :user_assignments, source: :user
  has_many :tasks, dependent: :destroy


  validates :name, presence: true
  #validates doers?


  accepts_nested_attributes_for :user_assignments # for nesting
  accepts_nested_attributes_for :tasks

  def to_s
    self.name
  end


  #is_done depends if subtasks are all done
  def is_ready
    if self.tasks.empty? and not self.is_done # no tasks assigned for this
      false
    elsif (self.tasks.find_by is_done: false).nil? # can't find any false => all tasks are done
      self.update_attribute(:is_done, true)
      true
    else
      false
    end
  end

  def get_creator
    User.all.find(self.creator_id)
  end

end
