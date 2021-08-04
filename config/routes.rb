Rails.application.routes.draw do

  root 'public#index'
  get 'guide/index'

  resources :posts do
    put 'upvote', on: :member
    put 'downvote', on: :member
    
    resources :comments, controller: 'posts/comments'
    resources :answers, controller: 'posts/answers' do
      get 'accept', on: :member
      put 'upvote', on: :member
      put 'downvote', on: :member
    end
  end

  devise_scope :user do
    get "user/edit" => "devise/registrations#edit", as: "edit_user"
  end
  
  devise_for :users
  resources :users
  
end
