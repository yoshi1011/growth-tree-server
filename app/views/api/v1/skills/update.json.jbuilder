json.success true
json.data do
  json.partial! 'api/v1/models/skill', skill: @skill
end
