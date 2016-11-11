defmodule ContactDemo.RoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Role

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Role.changeset(build(:role))
      assert changeset.valid?
    end

    test "name: if changeset has nil name" do
      changeset = Role.changeset(build(:role, name: nil))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has zero-length name" do
      changeset = Role.changeset(build(:role, name: ""))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has blank name" do
      changeset = Role.changeset(build(:role, name: " "))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many users_roles"

    @tag :skip
    test "has many users through users_roles"
  end
end
