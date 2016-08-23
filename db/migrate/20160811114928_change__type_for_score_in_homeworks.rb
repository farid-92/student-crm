class ChangeTypeForScoreInHomeworks < ActiveRecord::Migration
  def change
    change_column(:homeworks, :score, :decimal)
  end
end
