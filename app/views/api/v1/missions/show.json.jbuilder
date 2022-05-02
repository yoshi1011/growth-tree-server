json.success true
json.data do
  json.partial! 'api/v1/models/mission', mission: @mission
end
