class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question

  def create
    @answer = @question.answers.build(answer_params.merge({ user: current_user }))
    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
