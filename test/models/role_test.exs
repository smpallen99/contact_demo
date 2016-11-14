defmodule ContactDemo.RoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Role

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Role.changeset(%Role{}, params_with_assocs(:role))
      assert changeset.valid?
    end

    test "name: if changeset has nil name" do
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: nil}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has zero-length name" do
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: ""}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has blank name" do
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: " "}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: raises a validation error if the length of the text is > 255 characters" do
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: Faker.Lorem.words(256)}))
      refute changeset.valid?
      assert {:name, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many users_roles"

    @tag :skip
    test "has many users through users_roles"
  end
end
