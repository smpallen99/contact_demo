defmodule ContactDemo.ContactPhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactPhoneNumber

  describe "validations" do
    @valid_attrs %{contact_id: 1, phone_number_id: 1}
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

  describe "relationships" do
    @tag :skip
    test "belongs to contact"

    @tag :skip
    test "belongs to phone_number"
  end
end
