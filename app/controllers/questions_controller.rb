class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show update destroy]

  authorize_resource

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
    @question.attachments.build
  end

  def show
    if user_signed_in?
      @answer = current_user.answers.build
      @answer.attachments.build
    end
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created!'
    else
      render :new
    end
  end

  def update
    if @question.user == current_user
      @question.update(question_params)
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @question.user == current_user
      @question.destroy
      redirect_to questions_path
    else
      redirect_to @question, alert: 'You dont have such permission!'
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def build_attachment
    @question.attachments.build
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id])
  end
end
