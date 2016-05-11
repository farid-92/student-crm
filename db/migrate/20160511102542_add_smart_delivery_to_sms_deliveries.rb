class AddSmartDeliveryToSmsDeliveries < ActiveRecord::Migration
  def change
    add_column :sms_deliveries, :smart_delivery, :boolean, default: false
  end
end
