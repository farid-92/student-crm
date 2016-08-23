class ChangeTypeForScoreInHomeworks < ActiveRecord::Migration
  def change
    change_column(:homeworks, :score, 'decimal USING CAST(score AS decimal)') # for postgers use 'decimal USING CAST(score AS decimal)'
  end
end
