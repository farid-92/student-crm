class CourseElement < ActiveRecord::Base
  belongs_to :course
  has_many :periods

  validates :theme, :element_type, :course_id, presence: true
end
