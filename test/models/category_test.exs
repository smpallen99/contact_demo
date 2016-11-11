defmodule ContactDemo.CategoryTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Category

  describe "validations" do
    @valid_attrs params_for(:category)

    test "changeset with valid attributes" do
      changeset = Category.changeset(%Category{}, @valid_attrs)
      assert changeset.valid?
    end

    context "for name" do
      test "if changeset has nil name" do
        changeset = Category.changeset(build(:category, name: nil))
        refute changeset.valid?
        assert {:name, {"can't be blank", []}} in changeset.errors
      end

      test "if changeset has zero-length name" do
        changeset = Category.changeset(build(:category, name: ""))
        refute changeset.valid?
        assert {:name, {"can't be blank", []}} in changeset.errors
      end

      test "if changeset has blank name" do
        changeset = Category.changeset(build(:category, name: " "))
        refute changeset.valid?
        assert {:name, {"can't be blank", []}} in changeset.errors
      end
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contacts"
  end
end
