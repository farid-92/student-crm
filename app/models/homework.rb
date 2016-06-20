class Homework < ActiveRecord::Base
  before_save :set_file_name

  belongs_to :user
  belongs_to :period
  belongs_to :course
  belongs_to :group
  has_many :extra_homeworks

  # validates :score, inclusion: { in: '0'..'10' }
  validates :user_id, :period_id, :group_id, :course_id, presence: true
  validates :feedback, presence: true, on: :publish

  has_attached_file :hw,
                    :path => ':rails_root/public/system/:attachment/:id/:style/:normalized_file_name',
                    :url => '/system/:attachment/:id/:style/:normalized_file_name'

  Paperclip.interpolates :normalized_file_name do |attachment, style|
    attachment.instance.normalized_file_name
  end

  validates_attachment_content_type :hw, content_type: 'application/zip'
  validates_attachment_presence :hw

  def normalized_file_name
    if $file
      extension = File.extname($file.original_filename)
      student = Student.find(self.user_id)
      group = Group.find_by(course_id: self.course_id)
      period = Period.find(self.period_id)
      "#{student.name}-#{student.surname}-#{group.group_short_name}-hw-#{period.lesson_number}#{extension}"
    end
  end

  private

  def set_file_name
    self.hw_file_name = normalized_file_name
  end
end
