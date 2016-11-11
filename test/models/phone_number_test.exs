defmodule ContactDemo.PhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.PhoneNumber

  describe "validations" do
    @valid_attrs %{kind: "some content", label: "some content", number: "some content"}
    @invalid_attrs %{}

    test "changeset with valid attributes" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "relationships" do
    @tag :skip
    test "has many contacts_phone_numbers"

    @tag :skip
    test "has many contacts through contacts_phone_numbers"
  end

  describe "all_labels" do
    @tag :skip
    test "to be implemented"
  end

  describe "find_by_label" do
    @tag :skip
    test "to be implemented"
  end

  describe "label_abbr" do
    @tag :skip
    test "to be implemented"
  end

  describe "format_phone_numbers_abbriviated" do
    @tag :skip
    test "to be implemented"
  end
end
