json.extract! response, :id, :challenge_game_id, :user_id, :body, :created_at, :updated_at
json.url response_url(response, format: :json)
