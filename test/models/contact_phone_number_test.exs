defmodule Nested.ContactPhoneNumberTest do
  use Nested.ModelCase

  alias Nested.ContactPhoneNumber

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, @invalid_attrs)
    refute changeset.valid?
  end
end
