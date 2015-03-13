class Assignment < ActiveRecord::Base
  has_many :user_assignments #fix name
  has_many :doers, :through => :user_assignments, source: :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  #is_done depends if subtasks are all done


  def to_s
    self.name
  end

end
