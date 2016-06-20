class AddAttachmentHwToHomeworks < ActiveRecord::Migration
  def self.up
    change_table :homeworks do |t|
      t.attachment :hw
    end
  end

  def self.down
    remove_attachment :homeworks, :hw
  end
end
