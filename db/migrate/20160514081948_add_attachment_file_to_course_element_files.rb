class AddAttachmentFileToCourseElementFiles < ActiveRecord::Migration
  def self.up
    change_table :course_element_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :course_element_files, :file
  end
end
