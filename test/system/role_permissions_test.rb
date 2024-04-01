require "application_system_test_case"

class RolePermissionsTest < ApplicationSystemTestCase
  setup do
    @role_permission = role_permissions(:one)
  end

  test "visiting the index" do
    visit role_permissions_url
    assert_selector "h1", text: "Role permissions"
  end

  test "should create role permission" do
    visit role_permissions_url
    click_on "New role permission"

    fill_in "Permission", with: @role_permission.permission_id
    fill_in "Role", with: @role_permission.role_id
    click_on "Create Role permission"

    assert_text "Role permission was successfully created"
    click_on "Back"
  end

  test "should update Role permission" do
    visit role_permission_url(@role_permission)
    click_on "Edit this role permission", match: :first

    fill_in "Permission", with: @role_permission.permission_id
    fill_in "Role", with: @role_permission.role_id
    click_on "Update Role permission"

    assert_text "Role permission was successfully updated"
    click_on "Back"
  end

  test "should destroy Role permission" do
    visit role_permission_url(@role_permission)
    click_on "Destroy this role permission", match: :first

    assert_text "Role permission was successfully destroyed"
  end
end
