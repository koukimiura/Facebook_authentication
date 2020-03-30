class UsersController < ApplicationController
    before_action :authnecate_user!
    
    
    def show
        @user = User.find_by(id: params[:user_id])
    end
    
    
end
