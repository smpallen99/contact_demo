defmodule ContactDemo.UserRoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.UserRole

  @valid_attrs %{user_id: 1, role_id: 2}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserRole.changeset(%UserRole{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserRole.changeset(%UserRole{}, @invalid_attrs)
    refute changeset.valid?
  end
end
