class CourseElement < ActiveRecord::Base
  belongs_to :course
  has_many :periods
end
