json.array! @comments do |comment|
  json.partial! 'api/v1/models/comment', comment: comment
  json.attachments do
    json.array! comment.attachments do |attachment|
      son.partial! 'api/v1/models/attachment', attachment: attachment
    end
  end
end
