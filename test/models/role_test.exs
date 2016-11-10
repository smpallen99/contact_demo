defmodule ContactDemo.RoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Role

  describe "validations" do
    @valid_attrs %{name: "some content"}
    @invalid_attrs %{}

    test "changeset with valid attributes" do
      changeset = Role.changeset(%Role{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Role.changeset(%Role{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many users_roles"

    @tag :skip
    test "has many users through users_roles"
  end
end
