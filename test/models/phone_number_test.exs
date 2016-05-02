defmodule ContactDemo.PhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.PhoneNumber

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
