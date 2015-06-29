Rails.application.routes.draw do  
  devise_for :users

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  namespace :admin do
    root "static_pages#home"
    resources :positions, except: [:show, :new]
    resources :skills, except: [:show, :new]
    resources :activities, only: [:index, :destroy]
    resources :teams
    resources :users
    resources :projects
  end

  resources :users, only: [:show, :update] do
    resources :skill_users, only: :show
    match "/add_skill", to: "skill_users#show", via: :get
  end  
  resources :teams, only: [:index, :show]
end
