class User < ActiveRecord::Base
  has_many :tasks, :through => :assignments
  has_many :memberships
  has_many :assignments, :through => :memberships

  validates :name, uniqueness: true
  validates :name, length: {minimum: 3,
                            maximum: 15}


  def to_s
    self.name
  end

end
