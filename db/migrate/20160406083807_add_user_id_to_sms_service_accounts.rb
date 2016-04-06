class AddUserIdToSmsServiceAccounts < ActiveRecord::Migration
  def change
    add_reference :sms_service_accounts, :user, index: true, foreign_key: true
  end
end
