Rails.application.routes.draw do
  resources :posts do
    resources :comments   #nested routes
    resources :answers
  end
  
  devise_for :users
  root 'public#index'
  resources :users do
    get :edit, :on => :member
  end

end