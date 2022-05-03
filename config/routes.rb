Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'devise_overrides/registrations'
  }
  namespace :api do
    namespace :v1 do
      resources :users do
        # NOTE: パス名にassigned_curriculumsを使わないための措置。わかりやすいのかは随時見直し
        get '/curriculums', to: 'assigned_curriculums#index'
        post '/assign-curriculum', to: 'assigned_curriculums#create'
        patch '/curriculums/:curriculum_id/update-schedule', to: 'assigned_curriculums#update_schedule'
        patch '/curriculums/:curriculum_id/update-completed', to: 'assigned_curriculums#update_completed'
        delete '/curriculums/:curriculum_id/unassign-curriculum', to: 'assigned_curriculums#destroy'
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
      resources :skills
    end
  end
end
