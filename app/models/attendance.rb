class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :period

  def self.attended_periods(student_id, periods)
    where(user_id: student_id, period_id: periods, attended: true).count
  end

end
