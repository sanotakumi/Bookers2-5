class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit]}

  def ensure_current_user
    @user = User.find(params[:id])
    unless @user == current_user
       redirect_to user_path(current_user.id)
    end
  end

  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @user.id = current_user.id
  end

  def update
    @user = User.find(params[:id])
    @user.id = current_user.id
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
      flash.now[:alert]
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
