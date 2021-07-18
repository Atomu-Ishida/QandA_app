class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_admin_user, {only: [:show,:update, :destroy]}

 def index
   @users = User.all
 end

 def show
 end
 
 def new
   @user = User.new
 end

 def edit
   @user = User.find(params[:id])
 end

 def create
   @user = User.new(user_params)

   if @user.save 
     redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
   else
     render :new
   end
 end

 def update
   if @user.update(user_params)
     redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました"
   else
     render :new
   end
 end
 
 def destroy
   @user.destroy
   redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました"
 end
 

 private 

 def user_params
   params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
 end

 def require_admin
  if current_user.nil? || !current_user.admin?
    redirect_to root_path, notice: '管理者ではありません'
  end
 end

 def set_admin_user
  @user = User.find(params[:id])
end
 
 
end