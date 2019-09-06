require 'test_helper'

class GameMappingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_mapping = game_mappings(:one)
  end

  test "should get index" do
    get game_mappings_url
    assert_response :success
  end

  test "should get new" do
    get new_game_mapping_url
    assert_response :success
  end

  test "should create game_mapping" do
    assert_difference('GameMapping.count') do
      post game_mappings_url, params: { game_mapping: { challenge_id: @game_mapping.challenge_id, game_mapping_group_id: @game_mapping.game_mapping_group_id, sort: @game_mapping.sort } }
    end

    assert_redirected_to game_mapping_url(GameMapping.last)
  end

  test "should show game_mapping" do
    get game_mapping_url(@game_mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_mapping_url(@game_mapping)
    assert_response :success
  end

  test "should update game_mapping" do
    patch game_mapping_url(@game_mapping), params: { game_mapping: { challenge_id: @game_mapping.challenge_id, game_mapping_group_id: @game_mapping.game_mapping_group_id, sort: @game_mapping.sort } }
    assert_redirected_to game_mapping_url(@game_mapping)
  end

  test "should destroy game_mapping" do
    assert_difference('GameMapping.count', -1) do
      delete game_mapping_url(@game_mapping)
    end

    assert_redirected_to game_mappings_url
  end
end
