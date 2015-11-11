class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.date :starts_at
      t.date :ends_at

      t.timestamps null: false
    end
  end
end
