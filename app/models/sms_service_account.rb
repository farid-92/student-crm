class SmsServiceAccount < ActiveRecord::Base
  has_many :senders,  dependent: :destroy
  accepts_nested_attributes_for :senders, reject_if: proc { |attributes| attributes['name'].blank? }

  validates :login, presence: true, uniqueness: true
  validates :password, presence: true
end