defmodule ContactDemo.UserRoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.UserRole

  describe "validations" do
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

  describe "relationships" do
    @tag :skip
    test "belongs to user"

    @tag :skip
    test "belongs to role"
  end
end
