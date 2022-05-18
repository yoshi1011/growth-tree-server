json.id skill.id
json.name skill.name
json.description skill.description
json.users skill.users, partial: 'api/v1/models/user', as: :user
json.color skill.color
