class UserAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment

  validates :user, presence: :true
  validates :assignment, presence: :true

end
