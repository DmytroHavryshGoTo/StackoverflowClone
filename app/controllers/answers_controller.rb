class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_answer, only: %i[destroy update mark_best]

  def create
    @answer = @question.answers.build(answer_params.merge({ user: current_user }))
    @answer.save
  end

  def destroy
    if @answer.user == current_user
      @answer.destroy
    end
  end

  def update
    if @answer.user == current_user
      @answer.update(answer_params)
    end
  end

  def mark_best
    if @question.user == current_user
      @question.make_best(@answer)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
end
