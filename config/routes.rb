Rails.application.routes.draw do  
  devise_for :users

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  namespace :admin do
    root "static_pages#home"
    resources :positions, except: [:show, :new]
    resources :skills, except: [:show, :new]
    resources :teams, except: [:index, :show, :destroy]
  end

  resources :users, only: :show
end
