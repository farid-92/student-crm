class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.string :name
      t.references :sms_service_account, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
