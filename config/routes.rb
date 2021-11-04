Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about' => 'homes#about', as: 'about'
  post '/users/:id' => 'users#create'
  resources :users, only: [:index, :create, :show, :edit, :update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end