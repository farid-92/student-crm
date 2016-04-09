class CreateCustomLists < ActiveRecord::Migration
  def change
    create_table :custom_lists do |t|
      t.string :phone
      t.references :contact_list, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
