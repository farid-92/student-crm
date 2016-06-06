class AddAdditionColumnToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :lesson_number, :string
    add_column :periods, :start_time, :datetime
    add_column :periods, :end_time, :datetime
    add_reference :periods, :course, index: true, foreign_key: true
    add_reference :periods, :group, index: true, foreign_key: true
  end
end
