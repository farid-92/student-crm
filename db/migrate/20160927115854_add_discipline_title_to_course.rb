class AddDisciplineTitleToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :discipline_title, :string
  end
end
