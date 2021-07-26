Rails.application.routes.draw do

  root 'public#index'
  get 'guide/index'

  resources :posts do
    get 'upv', on: :member
    get 'dwv', on: :memer

    resources :comments, controller: 'posts/comments'
    resources :answers, controller: 'posts/answers' do
      get 'accept', on: :member
    end
  end

  devise_scope :user do
    get "user/edit" => "devise/registrations#edit", as: "edit_user"
  end
  
  devise_for :users
  resources :users
  
end
