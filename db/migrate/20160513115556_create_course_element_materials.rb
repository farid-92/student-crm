class CreateCourseElementMaterials < ActiveRecord::Migration
  def change
    create_table :course_element_materials do |t|
      t.string :title
      t.text :content
      t.string :element_type

      t.timestamps null: false
    end
  end
end
