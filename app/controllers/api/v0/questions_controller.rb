class Api::V0::QuestionsController < Api::V0::BaseController
  before_action :doorkeeper_authorize!, only: %w(create)
  before_action :load_question, only: %w(show)

  def index
    render json: Question.all
  end

  def create
    @question = current_resource_owner.questions.build(question_params)
    if (@question.save)
      render json: @question, status: 201
    else
      render json: @question.errors.full_messages.to_json, status: 400
    end
  end

  def show
    render json: @question
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
