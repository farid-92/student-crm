class Homework < ActiveRecord::Base

  belongs_to :user
  belongs_to :period
  belongs_to :course
  belongs_to :group
  has_many :extra_homeworks

end
