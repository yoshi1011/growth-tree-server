Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'devise_overrides/registrations'
  }
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :owned_skills, path: 'skills', only: [:create, :update, :destroy]
      end
      resources :curriculums
      resources :missions do
        resources :skill_points, path: 'skills', only: [:create, :update, :destroy]
      end
      resources :tasks
      resources :skills
    end
  end
end
