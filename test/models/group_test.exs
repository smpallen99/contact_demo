defmodule ContactDemo.GroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Group

  describe "validations" do
    @valid_attrs params_for(:group)

    test "changeset with valid attributes" do
      changeset = Group.changeset(%Group{}, @valid_attrs)
      assert changeset.valid?
    end

    context "for name" do
      test "if changeset has nil name" do
        changeset = Group.changeset(build(:group, name: nil))
        refute changeset.valid?
        assert {:name, {"can't be blank", []}} in changeset.errors
      end

      test "if changeset has zero-length name" do
        changeset = Group.changeset(build(:group, name: ""))
        refute changeset.valid?
        assert {:name, {"can't be blank", []}} in changeset.errors
      end

      test "if changeset has blank name" do
        changeset = Group.changeset(build(:group, name: " "))
        refute changeset.valid?
        assert {:name, {"can't be blank", []}} in changeset.errors
      end
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contact_groups"

    @tag :skip
    test "has many contacts through contact_groups"
  end
end
