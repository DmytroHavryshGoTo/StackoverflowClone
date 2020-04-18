class Answer < ApplicationRecord
  validates :body, presence: true
  belongs_to :question
  belongs_to :user

  default_scope { order(best: :desc, created_at: :asc) }

end
