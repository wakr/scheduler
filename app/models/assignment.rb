class Assignment < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true
  #is_done depends if subtasks are all done


  def to_s
    self.name
  end

end
