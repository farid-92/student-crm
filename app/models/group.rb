class Group < ActiveRecord::Base
  before_save :downcase_group_name

  belongs_to :course
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships, dependent: :destroy

  has_many :extra_homeworks, dependent: :destroy
  has_many :homeworks, dependent: :destroy

  has_many :periods, dependent: :destroy

  has_many :study_units

  validates :name,
            :group_short_name,
            :course_id,
            :starts_at,
            :ends_at,
            presence: true

  def downcase_group_name
    self.name.downcase!
    self.group_short_name.downcase!
  end

  def get_group_and_course
    "#{self.name} (#{self.course.name})"
  end

end
