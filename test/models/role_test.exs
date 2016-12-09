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
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: Lorem.words(256)}))
      refute changeset.valid?
      assert {:name, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    test "name: should be invalid when name is only numbers" do
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: "678"}))
      refute changeset.valid?
      assert {:name, {"has invalid format", []}} in changeset.errors
    end

    test "name: should be invalid when name starts with space" do
      changeset = Role.changeset(%Role{}, Map.merge(params_with_assocs(:role), %{name: " space"}))
      refute changeset.valid?
      assert {:name, {"has invalid format", []}} in changeset.errors
    end

    test "validates uniqueness of 'name' field" do
      original_role = insert(:role)
      duplicate_role = Role.changeset(%Role{}, params_with_assocs(:role, name: original_role.name))
      {:error, changeset} = Repo.insert duplicate_role
      assert {:name, {"has already been taken", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many users_roles"

    @tag :skip
    test "has many users through users_roles"
  end
end
