class AddAdditionColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :gender, :string
    add_column :users, :first_phone, :string
    add_column :users, :second_phone, :string
    add_column :users, :skype, :string
    add_column :users, :birthdate, :date
    add_column :users, :passport_id, :string
    add_column :users, :passport_inn, :string
    add_column :users, :issue_date, :date
    add_column :users, :issued_by, :string

  end
end
