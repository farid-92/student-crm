class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_short_name
      t.string :practical_time
      t.string :theoretical_time
      t.string :cost


      t.timestamps null: false
    end
  end
end
