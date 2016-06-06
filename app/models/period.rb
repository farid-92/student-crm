class Period < ActiveRecord::Base
  belongs_to :course_element
  belongs_to :study_unit
  belongs_to :course
  belongs_to :group

  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances, dependent: :destroy

  validates :title, :commence_datetime, :lesson_number, :group_id, :course_id, presence: true
  validates :lesson_number, numericality: true

  def self.past(group_id)
    where('commence_datetime < ? AND group_id == ?', Time.now, group_id)
  end

  def get_lesson_number_and_title
    "#{self.lesson_number}. #{self.title}"
  end

end
