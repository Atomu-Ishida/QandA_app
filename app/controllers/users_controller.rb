class UsersController < ApplicationController
    before_action :authenticate_user,{only:[:index,:show,:edit,:update]}
    before_action :ensure_correct_user, {only: [:edit, :update]}
    before_action :set_user, {only: [:show, :edit, :update]}

 def index
  @q = User.ransack(params[:q])
  @users = @q.result(distinct: true).page(params[:page]).per(10)
 end

 def show
 end
 
 def new
   @user = User.new
 end

 def edit
 end

 def create
   @user = User.new(user_params)

   if @user.save 
     session[:user_id] = @user.id
     redirect_to questions_url, notice: "ユーザー「#{@user.name}」を登録しました。"
   else
     render :new
   end
 end

 def update
   if @user.update(user_params)
     redirect_to user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました"
   else
     render :new
   end
 end
 
 def destroy
   @user = User.find(params[:id])
   @user.destroy
   redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました"
 end
 

 private 

 def user_params
   params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
 end

 def ensure_correct_user
    if @current_user.id != params[:id].to_i
      redirect_to root_url, notice: "権限がありません"
    end
 end

 def set_user
    @user = User.find(params[:id])
 end

end
