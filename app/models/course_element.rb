class CourseElement < ActiveRecord::Base
  belongs_to :course
  has_many :periods, dependent: :destroy
  has_many :course_element_materials, dependent: :destroy
  has_many :course_element_files, dependent: :destroy

  validates :theme, :element_type, :course_id, presence: true
end
