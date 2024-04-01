require "test_helper"

class RolePermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_permission = role_permissions(:one)
  end

  test "should get index" do
    get role_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_role_permission_url
    assert_response :success
  end

  test "should create role_permission" do
    assert_difference("RolePermission.count") do
      post role_permissions_url, params: { role_permission: { permission_id: @role_permission.permission_id, role_id: @role_permission.role_id } }
    end

    assert_redirected_to role_permission_url(RolePermission.last)
  end

  test "should show role_permission" do
    get role_permission_url(@role_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_permission_url(@role_permission)
    assert_response :success
  end

  test "should update role_permission" do
    patch role_permission_url(@role_permission), params: { role_permission: { permission_id: @role_permission.permission_id, role_id: @role_permission.role_id } }
    assert_redirected_to role_permission_url(@role_permission)
  end

  test "should destroy role_permission" do
    assert_difference("RolePermission.count", -1) do
      delete role_permission_url(@role_permission)
    end

    assert_redirected_to role_permissions_url
  end
end
