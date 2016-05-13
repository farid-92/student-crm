class Course < ActiveRecord::Base
  has_many :groups, dependent: :destroy
  has_many :course_elements, dependent: :destroy


  validates :name, :course_short_name, :cost, :practical_time, :theoretical_time, presence: true
end
