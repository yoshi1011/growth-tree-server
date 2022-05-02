Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'devise_overrides/registrations'
  }
  namespace :api do
    namespace :v1 do
      resources :curriculums
      resources :missions
      resources :tasks
    end
  end
end
