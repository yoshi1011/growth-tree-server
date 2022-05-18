json.extract! mission, :id, :name, :description

json.setting_count mission.assigned_missions.length

json.skills mission.skills, partial: 'api/v1/models/skill', as: :skill
json.tasks mission.tasks, partial: 'api/v1/models/task', as: :task
