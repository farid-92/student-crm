class CreateStudyUnits < ActiveRecord::Migration
  def change
    create_table :study_units do |t|
      t.string :unit
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
