class SmsDelivery < ActiveRecord::Base
  belongs_to :contact_list
  belongs_to :sender

  validates :title, presence: true, length: { maximum: 70 }
  validates :content, presence: true, length: { maximum: 800 }
  validates :contact_list, presence: true
  validates :sender, presence: true

end
