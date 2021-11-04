class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit]}

  def ensure_current_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
       redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "Book was successfully created."
       redirect_to book_path(@book)
    else
       flash.now[:alert]
       @books = Book.all
       render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path
    else
      flash.now[:alert]
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.user_id = current_user.id
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
