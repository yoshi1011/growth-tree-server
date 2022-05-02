json.success true
json.data do
  json.array! @curriculums, partial: 'api/v1/models/curriculum', curriculum: @curriculum
end
