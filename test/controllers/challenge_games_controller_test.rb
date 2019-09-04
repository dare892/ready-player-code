require 'test_helper'

class ChallengeGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @challenge_game = challenge_games(:one)
  end

  test "should get index" do
    get challenge_games_url
    assert_response :success
  end

  test "should get new" do
    get new_challenge_game_url
    assert_response :success
  end

  test "should create challenge_game" do
    assert_difference('ChallengeGame.count') do
      post challenge_games_url, params: { challenge_game: { challenge_id: @challenge_game.challenge_id, game_id: @challenge_game.game_id } }
    end

    assert_redirected_to challenge_game_url(ChallengeGame.last)
  end

  test "should show challenge_game" do
    get challenge_game_url(@challenge_game)
    assert_response :success
  end

  test "should get edit" do
    get edit_challenge_game_url(@challenge_game)
    assert_response :success
  end

  test "should update challenge_game" do
    patch challenge_game_url(@challenge_game), params: { challenge_game: { challenge_id: @challenge_game.challenge_id, game_id: @challenge_game.game_id } }
    assert_redirected_to challenge_game_url(@challenge_game)
  end

  test "should destroy challenge_game" do
    assert_difference('ChallengeGame.count', -1) do
      delete challenge_game_url(@challenge_game)
    end

    assert_redirected_to challenge_games_url
  end
end
