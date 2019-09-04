json.extract! room_user, :id, :user_id, :room_id, :role, :created_at, :updated_at
json.url room_user_url(room_user, format: :json)
