class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  has_many :answers, dependent: :delete_all
  belongs_to :user

  default_scope { order(:created_at) }

  def make_best(answer)
    previous_best = answers.where(best: true).first
    if previous_best.present?
      previous_best.best = false
      previous_best.save
    end
    answer.best = true
    answer.save
  end
end
