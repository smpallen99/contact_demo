defmodule ContactDemo.ContactTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Contact

  describe "validations" do
    @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", category_id: 1}
    @invalid_attrs %{}

    test "changeset with valid attributes" do
      changeset = Contact.changeset(%Contact{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Contact.changeset(%Contact{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to category"

    @tag :skip
    test "has many contacts_groups"

    @tag :skip
    test "has many groups through contact_groups"

    @tag :skip
    test "has many contacts_phone_numbers"

    @tag :skip
    test "has many phone_numbers through contacts_phone_numbers"
  end
end
