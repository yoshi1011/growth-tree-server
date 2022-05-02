json.success true
json.data do
  json.array! @skills, partial: 'api/v1/models/skill', skill: @skill
end
