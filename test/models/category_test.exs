defmodule ContactDemo.CategoryTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Category

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Category.changeset(%Category{}, params_with_assocs(:category))
      assert changeset.valid?
    end

    test "name: if changeset has nil name" do
      changeset = Category.changeset(%Category{}, Map.merge(params_with_assocs(:category), %{name: nil}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has zero-length name" do
      changeset = Category.changeset(%Category{}, Map.merge(params_with_assocs(:category), %{name: ""}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has blank name" do
      changeset = Category.changeset(%Category{}, Map.merge(params_with_assocs(:category), %{name: " "}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contacts"
  end
end
