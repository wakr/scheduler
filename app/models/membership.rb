class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  # avoid saving useless shit to db.
  validates :group_id, presence: true
  validates :user_id, presence: true

  def self.membership_exists?(user_id, group_id)
    allready_exists = self.find_mem(user_id, group_id)
    !allready_exists.nil?
  end

  def self.find_mem(user_id, group_id)
    Membership.where(:user_id => user_id, :group_id => group_id).first
  end
end
