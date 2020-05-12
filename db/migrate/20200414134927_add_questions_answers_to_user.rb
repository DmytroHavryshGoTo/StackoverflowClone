class AddQuestionsAnswersToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :user, foreign_key: true, index: true
    add_reference :answers, :user, foreign_key: true, index: true
  end
end
