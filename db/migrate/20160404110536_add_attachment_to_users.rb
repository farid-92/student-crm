class AddAttachmentToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :photo
      t.attachment :passport_photo
    end
  end

  def self.down
    remove_attachment :users, :photo
    remove_attachment :users, :password_photo
  end
end
