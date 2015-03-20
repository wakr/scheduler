class Assignment < ActiveRecord::Base
  has_many :user_assignments, dependent: :destroy #fix name
  has_many :doers, :through => :user_assignments, source: :user
  has_many :tasks, dependent: :destroy


  validates :name, presence: true
  #is_done depends if subtasks are all done

  accepts_nested_attributes_for :user_assignments # for nesting
  accepts_nested_attributes_for :tasks

  def to_s
    self.name
  end

  def get_creator
    User.all.find(self.creator_id)
  end

end
