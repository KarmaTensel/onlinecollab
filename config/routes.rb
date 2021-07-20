Rails.application.routes.draw do

  get 'guide/index'
  root 'public#index'

  resources :posts do
    resources :comments
    resources :answers, controller: 'posts/answers'
  end

  devise_scope :user do
    get "user/edit" => "devise/registrations#edit", as: "edit_user"
  end
  
  devise_for :users
  resources :users
  
end
