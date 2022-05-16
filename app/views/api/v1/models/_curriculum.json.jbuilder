json.extract! curriculum, :id, :name, :description

json.users curriculum.employees, partial: 'api/v1/models/user', as: :user
json.missions curriculum.missions, partial: 'api/v1/models/mission', as: :mission
