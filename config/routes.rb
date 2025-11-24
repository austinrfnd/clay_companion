# frozen_string_literal: true

##
# Application Routes
#
# Defines all routes for Clay Companion application.
# Includes custom Devise authentication routes matching wireframe requirements.
#
# Authentication Routes:
# - /login (instead of /artists/sign_in)
# - /signup (instead of /artists/sign_up)
# - /logout (instead of /artists/sign_out)
# - /password/reset (instead of /artists/password/new)
# - /email/verify/:token (instead of /artists/confirmation)
#
Rails.application.routes.draw do
  # Custom Devise routes matching wireframe URLs
  devise_for :artists, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup',
    password: 'password/reset',
    confirmation: 'email/verify'
  }, controllers: {
    sessions: 'artists/sessions',
    registrations: 'artists/registrations',
    passwords: 'artists/passwords',
    confirmations: 'artists/confirmations'
  }

  # Override Devise default routes to match wireframe requirements
  # Signup: POST /signup (Devise creates POST / for registrations when path is '')
  post '/signup', to: 'artists/registrations#create'
  
  # Password reset routes wrapped in devise_scope for proper Devise mapping
  devise_scope :artist do
    # Password reset: /password/reset (not /password/reset/new)
    get '/password/reset', to: 'artists/passwords#new', as: :password_reset_request
    post '/password/reset', to: 'artists/passwords#create'
    
    # Password reset with token: /password/reset/:token (not /password/reset/edit)
    get '/password/reset/:reset_password_token', to: 'artists/passwords#edit', as: :password_reset_edit
    patch '/password/reset/:reset_password_token', to: 'artists/passwords#update'
    put '/password/reset/:reset_password_token', to: 'artists/passwords#update'
  end

  # Email confirmation routes wrapped in devise_scope for proper Devise mapping
  devise_scope :artist do
    # Email confirmation: /email/verify/:token (not /email/verify)
    get '/email/verify/:confirmation_token', to: 'artists/confirmations#show', as: :email_verification
    
    # Resend confirmation email form: GET /email/resend
    get '/email/resend', to: 'artists/confirmations#new', as: :new_confirmation
    
    # Resend confirmation email: POST /email/resend
    post '/email/resend', to: 'artists/confirmations#create', as: :resend_confirmation
  end

  # Custom route helpers for cleaner code
  # These will be available as login_path, signup_path, logout_path, etc.
  # via Devise's path_names configuration above

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "welcome#index"

  # Stub routes for auth redirects (to be implemented in later phases)
  # These are temporary routes to allow controller tests to pass
  get '/dashboard', to: 'dashboard#index', as: :dashboard
  get '/profile_setup', to: 'profile_setup#show', as: :profile_setup
  patch '/profile_setup', to: 'profile_setup#update'
  get '/email_verification_sent', to: 'email_verification#sent', as: :email_verification_sent

  # Settings hub routes
  namespace :dashboard do
    namespace :settings do
      root to: 'settings#index'
      resource :account, only: [:show, :update], controller: 'account'
      resource :profile, only: [:show, :update], controller: 'profile'
      resource :studio, only: [:show], controller: 'studio'
      # Privacy, Work routes to be added in future phases
    end
  end

  # API routes for studio feature
  namespace :api do
    scope '/artists/:artist_id' do
      resources :studio_images, only: [:index, :show, :create, :update, :destroy], path: 'studio-images'
      resource :studio_page, only: [:show, :update], path: 'studio-page', controller: 'studio_page'
    end
  end
end
