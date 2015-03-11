class Task < ActiveRecord::Base
  belongs_to :assignment

  validates :name, presence: true
  validates :assignment_id, presence: true
end
