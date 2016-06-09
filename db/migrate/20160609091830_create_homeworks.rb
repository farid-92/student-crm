class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.references :course, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.string :score
      t.text :feedback
      t.datetime :deadline
      t.string :teacher_id, default: false

      t.timestamps null: false
    end
  end
end
