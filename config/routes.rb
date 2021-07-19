Rails.application.routes.draw do
  resources :posts do
    resources :comments   #nested routes
    resources :answers
    get 'accept_answer', :on => :member
  end
  
  devise_for :users
  devise_scope :user do
    patch 'update', to: 'registrations#update', as: 'edit_user_path'
  end

  root 'public#index'
  resources :users do
    put :edit, :on => :member
  end

end