class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users, status: 200
    end



    def create
        @user = User.new(user_params)
        if @user.save
            render json: params
        else
            render json: @user.errors.full_messages, status: 422
        end
    end


    def show
        @user = User.find_by(id: params[:id])

        if @user
            render json: @user, status: 200
        else   
            render json: "User not found", status: 404
        end
    end

    def update
        @user = User.find(params[:id])
        @user.update!(user_params)
        render json: @user
    end

    def destroy
        # User.find(params[:id]).destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_url
    end

    private
    def user_params
        params.require(:user).permit(:name, :email)
    end

end