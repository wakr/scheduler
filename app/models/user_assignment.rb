class UserAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment

  # avoid saving useless shit to db.
  validates :user_id, presence: true
  validates :assignment_id, presence: true
  validates :creator_id, presence: true

end
