class SmsServiceAccount < ActiveRecord::Base
  belongs_to :user
  has_many :senders,  dependent: :destroy

  validates :login, presence: true, uniqueness: true
  validates :password, presence: true
end