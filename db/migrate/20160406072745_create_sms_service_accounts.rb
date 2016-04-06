class CreateSmsServiceAccounts < ActiveRecord::Migration
  def change
    create_table :sms_service_accounts do |t|
      t.string :login
      t.string :password
      t.timestamps null: false
    end
  end
end
