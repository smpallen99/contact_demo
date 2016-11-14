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

    test "name: raises a validation error if the length of the text is > 255 characters" do
      changeset = Category.changeset(%Category{}, Map.merge(params_with_assocs(:category), %{name: Faker.Lorem.words(256)}))
      refute changeset.valid?
      assert {:name, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contacts"
  end
end
