json.success true
json.data do
  json.partial! 'api/v1/models/owned_skill', owned_skill: @owned_skill
end
