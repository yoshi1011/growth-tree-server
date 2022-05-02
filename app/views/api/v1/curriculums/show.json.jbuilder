json.success true
json.data do
  json.partial! 'api/v1/models/curriculum', curriculum: @curriculum
end
