class User < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :tasks, :through => :assignments
end
