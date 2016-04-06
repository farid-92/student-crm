class Sender < ActiveRecord::Base
  belongs_to :sms_service_account
  has_many :sms_deliveries, dependent: :destroy

end
