class Group < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :members, :through => :memberships, source: :user

  validates :name, presence: true, allow_blank: false,
            length: {minimum: 1, maximum: 18}
end
