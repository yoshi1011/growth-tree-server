json.extract! mission, :id, :name, :description

json.skills mission.skills, partial: 'api/v1/models/skill', as: :skill
