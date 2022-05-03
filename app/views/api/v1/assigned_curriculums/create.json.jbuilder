json.partial! 'api/v1/models/assigned_curriculum', assigned_curriculum: @assigned_curriculum
json.missions do
  json.array! @assigned_curriculum.assigned_missions do |assigned_mission|
    json.partial! 'api/v1/models/assigned_mission', assigned_mission: assigned_mission
    json.tasks do
      json.array! assigned_mission.assigned_tasks do |assigned_task|
        json.partial! 'api/v1/models/assigned_task', assigned_task: assigned_task
      end
    end
  end
end
