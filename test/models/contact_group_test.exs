defmodule ContactDemo.ContactGroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactGroup

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
