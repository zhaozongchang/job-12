Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :jobs do
    resources :resumes
    collection do
      get :search
      get :information
      get :education
      get :medical
      get :manage
      get :page_design
      get :operation
      get :marketing
      get :administrative
    end
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end
end
