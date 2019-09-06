require 'test_helper'

class GameMappingGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_mapping_group = game_mapping_groups(:one)
  end

  test "should get index" do
    get game_mapping_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_game_mapping_group_url
    assert_response :success
  end

  test "should create game_mapping_group" do
    assert_difference('GameMappingGroup.count') do
      post game_mapping_groups_url, params: { game_mapping_group: { difficulty: @game_mapping_group.difficulty, language_id: @game_mapping_group.language_id } }
    end

    assert_redirected_to game_mapping_group_url(GameMappingGroup.last)
  end

  test "should show game_mapping_group" do
    get game_mapping_group_url(@game_mapping_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_mapping_group_url(@game_mapping_group)
    assert_response :success
  end

  test "should update game_mapping_group" do
    patch game_mapping_group_url(@game_mapping_group), params: { game_mapping_group: { difficulty: @game_mapping_group.difficulty, language_id: @game_mapping_group.language_id } }
    assert_redirected_to game_mapping_group_url(@game_mapping_group)
  end

  test "should destroy game_mapping_group" do
    assert_difference('GameMappingGroup.count', -1) do
      delete game_mapping_group_url(@game_mapping_group)
    end

    assert_redirected_to game_mapping_groups_url
  end
end
