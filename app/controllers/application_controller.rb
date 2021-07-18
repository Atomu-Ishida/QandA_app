class ApplicationController < ActionController::Base
    before_action :current_user


    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    

    def authenticate_user 
        if @current_user == nil
          redirect_to login_path, notice: "ログインが必要です。"
        end
    end
end