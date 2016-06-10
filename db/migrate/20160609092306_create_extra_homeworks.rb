class CreateExtraHomeworks < ActiveRecord::Migration
  def change
    create_table :extra_homeworks do |t|
      t.references :group, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.references :homework, foreign_key: true
      t.text :feedback
      t.boolean :download_status, default: false
      t.string :teacher_id, default: false

      t.timestamps null: false
    end
  end
end
