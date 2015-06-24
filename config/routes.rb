Rails.application.routes.draw do  
  devise_for :users

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  namespace :admin do
    root "static_pages#home"
    resources :positions, except: [:show, :new]
    resources :skills, except: [:show, :new]
    resources :users, except: [:index, :show, :destroy]
    resources :teams
  end

  resources :users, only: :show
  resources :teams, only: [:index, :show]
end
