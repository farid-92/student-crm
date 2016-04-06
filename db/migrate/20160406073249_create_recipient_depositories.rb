class CreateRecipientDepositories < ActiveRecord::Migration
  def change
    create_table :recipient_depositories do |t|
      t.references :user, index: true, foreign_key: true
      t.references :contact_list, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
