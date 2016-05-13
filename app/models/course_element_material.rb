class CourseElementMaterial < ActiveRecord::Base

  belongs_to :course_element

  validates :content, :title, :element_type, presence: true

end
