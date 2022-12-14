Rails.application.routes.draw do
  resources :filesystem_items

  resources :notifications, only: %i[index]

  resources :todos do
    member do
      patch :move
    end
  end

  resources :list_items do
    member do
      patch :move
    end
  end

  resources :todo_list do
    member do
      patch :move
      patch :move_item
    end
  end

  resources :lists

  resources :applicants do
    patch :change_stage, on: :member
    resources :emails, only: %i[index new create show]
    get :resume, action: :show, controller: 'resumes'
    resources :email_replies, only: %i[new]
  end

  resources :jobs
  devise_for :users,
             path: '',
             controllers: {
               registrations: 'users/registrations',
               sessions: 'users/sessions',
             },
             path_names: {
               sign_in: 'login',
               password: 'forgot',
               confirmation: 'confirm',
               sign_up: 'sign_up',
               sign_out: 'sign_out'
             }

  get 'dashboard/show'

  authenticated :user do
    root to: 'dashboard#show', as: :user_root
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
