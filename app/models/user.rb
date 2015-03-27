class User < ActiveRecord::Base
  #group
  has_many :memberships
  has_many :groups, :through => :memberships

  #assignments
  has_many :user_assignments
  has_many :assignments, :through => :user_assignments
  has_many :tasks, :through => :assignments

  #passwrd
  has_secure_password

  validates :name, uniqueness: true
  validates :name, length: {minimum: 3,
                            maximum: 15}
  validates_format_of :password, :with => /(?=.*\d)(?=.*([A-Z]))/
  validates :password, length: {minimum: 4}

  #scopes

  scope :all_except, ->(user) { where.not(id: user) } #returns all except parameter user

  def to_s
    self.name
  end

  def get_created_assignments
    Assignment.where(creator_id: self.id)
  end

  private
  def self.all_except(user)
    where.not(id: user)
  end

  def self.all_who_are_in_same_group_as_creator(current_user)
    group_ids = current_user.groups.map{|g| g.id}
    user_ids = Membership.where(group_id: group_ids).map{|u| u.user_id}
    user_ids = user_ids - [current_user.id] unless user_ids.empty?
    User.where(id: user_ids)
  end

end
