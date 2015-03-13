class User < ActiveRecord::Base
  #group
  has_many :memberships
  has_many :groups, :through => :memberships
  #assignments
  has_many :user_assignments
  has_many :assignments, :through => :user_assignments
  has_many :tasks, :through => :assignments

  validates :name, uniqueness: true
  validates :name, length: {minimum: 3,
                            maximum: 15}


  def to_s
    self.name
  end

end
