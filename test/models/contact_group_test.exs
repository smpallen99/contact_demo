defmodule ContactDemo.ContactGroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactGroup

  describe "validations" do
    @valid_attrs %{contact_id: 1, group_id: 1}
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

  describe "relationships" do
    @tag :skip
    test "belongs to contact"

    @tag :skip
    test "belongs to group"
  end
end
