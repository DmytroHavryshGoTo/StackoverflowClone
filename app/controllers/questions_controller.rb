class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def show
    @answer = @question.answers.new
    @answers = @question.answers
  end

  def edit
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
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
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

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
