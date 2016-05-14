class CourseElementFile < ActiveRecord::Base
  include Paperclip::Glue

  belongs_to :course_element

  has_attached_file :file

  do_not_validate_attachment_file_type :file


end
