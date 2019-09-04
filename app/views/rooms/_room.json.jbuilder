json.extract! room, :id, :name, :pin, :language_id, :mode, :difficulty, :status, :created_at, :updated_at
json.url room_url(room, format: :json)
