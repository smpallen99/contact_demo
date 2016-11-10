defmodule ContactDemo.GroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Group

  describe "validations" do
    @valid_attrs %{name: "some content"}
    @invalid_attrs %{}

    test "changeset with valid attributes" do
      changeset = Group.changeset(%Group{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Group.changeset(%Group{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contact_groups"

    @tag :skip
    test "has many contacts through contact_groups"
  end
end
