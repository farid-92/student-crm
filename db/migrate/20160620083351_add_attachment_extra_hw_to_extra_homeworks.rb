class AddAttachmentExtraHwToExtraHomeworks < ActiveRecord::Migration
  def self.up
    change_table :extra_homeworks do |t|
      t.attachment :extra_hw
    end
  end

  def self.down
    remove_attachment :extra_homeworks, :extra_hw
  end
end
