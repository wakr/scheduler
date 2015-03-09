class User < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :tasks, :through => :assignments

  validates :name, uniqueness: true
  validates :name, length: {minimum: 3,
                            maximum: 15}
end
