Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'devise_overrides/registrations'
  }
  namespace :api do
    namespace :v1 do
      resources :users do
        member do
          post :update_role
        end

        resources :assigned_curriculums do
          member do
            patch :update_schedule
            patch :update_completed
          end
        end

        resources :assigned_missions do
          member do
            patch :update_schedule
            patch :update_completed
          end
        end

        resources :owned_skills, path: 'skills', only: [:create, :update, :destroy]

        resources :assigned_tasks do
          resources :comments
        end
      end
      resources :curriculums
      resources :missions do
        resources :skill_points, path: 'skills', only: [:create, :update, :destroy]
      end
      resources :tasks

      resources :set_missions, only: [:create, :destroy]
      resources :set_tasks, only: [:create, :destroy]

      resources :skills
    end
  end
end
