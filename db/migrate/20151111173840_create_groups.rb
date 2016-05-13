class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :course, index: true, foreign_key: true
      t.string :name
      t.string :group_short_name
      t.date :starts_at
      t.date :ends_at

      t.timestamps null: false
    end
  end
end
