defmodule ContactDemo.GroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Group

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Group.changeset(%Group{}, params_with_assocs(:group))
      assert changeset.valid?
    end

    test "name: if changeset has nil name" do
      changeset = Group.changeset(%Group{}, Map.merge(params_with_assocs(:group), %{name: nil}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has zero-length name" do
      changeset = Group.changeset(%Group{}, Map.merge(params_with_assocs(:group), %{name: ""}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has blank name" do
      changeset = Group.changeset(%Group{}, Map.merge(params_with_assocs(:group), %{name: " "}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: should be invalid when name is only numbers" do
      changeset = Group.changeset(%Group{}, Map.merge(params_with_assocs(:group), %{name: "678"}))
      refute changeset.valid?
      assert {:name, {"has invalid format", []}} in changeset.errors
    end

    test "name: should be invalid when name starts with space" do
      changeset = Group.changeset(%Group{}, Map.merge(params_with_assocs(:group), %{name: " space"}))
      refute changeset.valid?
      assert {:name, {"has invalid format", []}} in changeset.errors
    end

    test "name: raises a validation error if the length of the text is > 255 characters" do
      changeset = Group.changeset(%Group{}, Map.merge(params_with_assocs(:group), %{name: Lorem.words(256)}))
      refute changeset.valid?
      assert {:name, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    test "validates uniqueness of 'name' field" do
      original_group = insert(:group)
      duplicate_group = Group.changeset(%Group{}, params_with_assocs(:group, name: original_group.name))
      {:error, changeset} = Repo.insert duplicate_group
      assert {:name, {"has already been taken", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contact_groups"

    @tag :skip
    test "has many contacts through contact_groups"
  end
end
