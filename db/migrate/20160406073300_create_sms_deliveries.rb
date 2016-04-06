class CreateSmsDeliveries < ActiveRecord::Migration
  def change
    create_table :sms_deliveries do |t|
      t.string :title
      t.text :content
      t.references :sender, index: true, foreign_key: true
      t.references :contact_list, index: true, foreign_key: true
      t.boolean :status, default: false
      t.datetime :delivery_time
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
