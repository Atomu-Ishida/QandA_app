class AnswerMailer < ApplicationMailer
    def creation_answer
        @answer = params[:answer]
        mail(
            subject: "回答です",
            to: @answer.question.user.email,
            from: 'qanda@example.com'
        )
    end

    def creation_other_answers
        @user = params[:user]
        @answer = params[:answer]
        mail(
            subject: '他の人の回答', to: @user.email, from: 'qanda@example.com'
        )
      end
end
