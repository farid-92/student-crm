class ContactList < ActiveRecord::Base
  has_many :recipient_depositories
  has_many :users, through: :recipient_depositories
  has_many :sms_deliveries, dependent: :destroy
  has_many :custom_lists, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end

