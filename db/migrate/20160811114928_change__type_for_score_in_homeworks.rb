class ChangeTypeForScoreInHomeworks < ActiveRecord::Migration
  def change
    change_column(:homeworks, :score, 'decimal') # for postgers use 'decimal USING CAST(score AS decimal)'
  end
end
