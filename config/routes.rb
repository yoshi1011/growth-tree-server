Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'devise_overrides/registrations',
    sessions: 'devise_overrides/sessions',
    token_validations: 'devise_overrides/token_validations',
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
      resources :curriculums do
        post '/missions/:mission_id', to: 'api/v1/set_missions#create'
        delete '/missions/:mission_id', to: 'api/v1/set_missions#destroy'
      end
      resources :missions do
        post '/tasks/:task_id', to: 'api/v1/set_tasks#create'
        delete '/tasks/:task_id', to: 'api/v1/set_tasks#destroy'

        resources :skill_points, path: 'points', only: [:create, :update, :destroy]
      end
      resources :tasks

      resources :skills
    end
  end
end
