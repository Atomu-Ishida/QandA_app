class AnswersController < ApplicationController
    before_action :authenticate_user
    
    
    
    def create
      @answer = Answer.new(answer_params)
      @answer.user_id = current_user.id
      @answer.question_id  = params[:question_id]
      if @answer.save!
        AnswerMailer.with(answer: @answer).creation_answer.deliver_now

        answers = Answer.where(question_id: @answer.question_id)
        user_ids = answers.pluck(:user_id)
        users = User.where(id: user_ids)
        users.each do |user|
          next if user == current_user
          AnswerMailer.with(user: user, answer: @answer).creation_other_answers.deliver_now
        end
        redirect_to("/questions/#{params[:question_id]}")         
      else
        render :new
      end
    end

    
      
    private
      def answer_params
        params.require(:answer).permit(:description).merge(question_id: params[:question_id] )
      end
  
end
