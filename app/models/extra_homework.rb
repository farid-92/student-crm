class ExtraHomework < ActiveRecord::Base

  belongs_to :user
  belongs_to :period
  belongs_to :course
  belongs_to :group
  belongs_to :homework
end
