class Api::V0::AnswersController < Api::V0::BaseController
  before_action :doorkeeper_authorize!, only: %w(create)
  before_action :load_question, only: %w(show index create)

  def index
    render json: @question.answers
  end

  def create
    @answer = @question.answers.build(answer_params.merge({ user: current_resource_owner }))
    if (@answer.save)
      render json: @answer, status: 201
    else
      render json: @answer.errors.full_messages.to_json, status: 400
    end
  end

  def show
    render json: @question.answers.find(params[:id])
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
