Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # https://guides.rubyonrails.org/routing.html#resource-routing-the-rails-default
  resources :books, only: [:index, :show, :destroy]
  resources :fiction_books, only: [:index, :create]
  resources :nonfiction_books, only: [:index, :create]
  resources :reviews, only: [:create]
end
