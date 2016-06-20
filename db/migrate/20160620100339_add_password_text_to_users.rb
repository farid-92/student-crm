class AddPasswordTextToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_txt, :string
  end
end
