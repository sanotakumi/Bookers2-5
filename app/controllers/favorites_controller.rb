class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    session[:previous_url] = request.referer 
    redirect_to session[:previous_url]
   
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    session[:previous_url] = request.referer 
    redirect_to session[:previous_url]
  end
end