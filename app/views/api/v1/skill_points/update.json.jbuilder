json.success true
json.data do
  json.partial! 'api/v1/models/skill_point', skill_point: @skill_point
end
