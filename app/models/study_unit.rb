class StudyUnit < ActiveRecord::Base
  belongs_to :group

  has_many :periods, dependent: :nullify

  validates :unit,
            :group_id,
            :period_ids,
            presence: true
end
