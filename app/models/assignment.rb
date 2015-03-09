class Assignment < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy

  #is_done depends if subtasks are all done


  def is_done

  end

  def to_s
    self.name
  end

end
