class CreateCourseElementFiles < ActiveRecord::Migration
  def change
    create_table :course_element_files do |t|
      t.references :course_element, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
