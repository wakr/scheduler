class User < ActiveRecord::Base
  #group
  has_many :memberships
  has_many :groups, :through => :memberships
  #assignments
  has_many :user_assignments
  has_many :assignments, :through => :user_assignments
  has_many :tasks, :through => :assignments

  #passowrd
  has_secure_password

  validates :name, uniqueness: true
  validates :name, length: {minimum: 3,
                            maximum: 15}
  validates_format_of :password, :with => /(?=.*\d)(?=.*([A-Z]))/
  validates :password, length: {minimum: 4}


  def to_s
    self.name
  end

end
