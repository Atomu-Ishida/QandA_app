class QuestionsController < ApplicationController
 
  before_action :authenticate_user, {only:[:new, :create, :edit, :update, :destroy]}
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}
  before_action :set_question, {only:[:show, :edit, :update, :destroy]}


  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(8)
  end

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save!
      User.all.each do |user|
       next if user == current_user
       QuestionMailer.with(user: user, question: @question).creation_email.deliver_now
      end
       redirect_to questions_url, notice: "質問 「#{@question.title}」を投稿しました。" 
    else
      render :new
    end
  end

  def update
    @question.update!(question_params)
    redirect_to questions_url, notice: "質問 「#{@question.title}」を更新しました。"
  end
  
  def destroy
    @question.destroy!
    redirect_to questions_url, notice: "質問 「#{@question.title}」を削除しました。"
  end

  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: 0).page(params[:page]).per(10)
    render :action => 'index'
  end
  
  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
    render :action => 'index'
  end
  
  private
  def question_params
    # byebug
    params.require(:question).permit(:title,:description,:solved)
  end

  def ensure_correct_user
    @question = Question.find_by(id: params[:id])
    if @question.user_id != current_user.id
      redirect_to root_url, notice: "管理者権限がありません"
    end
  end
  
  def set_question
    @question = Question.find(params[:id])
  end
end
