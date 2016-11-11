defmodule ContactDemo.GroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Group

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Group.changeset(build(:group))
      assert changeset.valid?
    end

    test "name: if changeset has nil name" do
      changeset = Group.changeset(build(:group, name: nil))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has zero-length name" do
      changeset = Group.changeset(build(:group, name: ""))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has blank name" do
      changeset = Group.changeset(build(:group, name: " "))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contact_groups"

    @tag :skip
    test "has many contacts through contact_groups"
  end
end
