defmodule Nested.ContactGroupTest do
  use Nested.ModelCase

  alias Nested.ContactGroup

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ContactGroup.changeset(%ContactGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ContactGroup.changeset(%ContactGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
