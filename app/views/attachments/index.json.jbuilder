json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :image, :position, :post_id, :comment
  json.url attachment_url(attachment, format: :json)
end
