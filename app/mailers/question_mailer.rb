class QuestionMailer < ApplicationMailer  

  def creation_email
    @user = params[:user]
    @question = params[:question]
    mail(
        subject: '新規質問',
        to: @user.email, 
        from: "qanda@example.com"
    )
  end 

  def self.creation_email_questions
    @users = User.all
    @users.each do |user|
      QuestionMailer.creation_email(user).deliver_now
    end
  end
end
