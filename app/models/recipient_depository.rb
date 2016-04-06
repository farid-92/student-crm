class RecipientDepository < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact_list
end
