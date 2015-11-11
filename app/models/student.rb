class Student < ActiveRecord::Base
  has_many :group_memberships
  has_many :groups, through: :group_memberships
end
