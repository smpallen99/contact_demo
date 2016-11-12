defmodule ContactDemo.ContactPhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactPhoneNumber

  describe "validations" do
    test "changeset with valid attributes" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (contact, phone_number)
      changeset = ContactPhoneNumber.changeset(build(:contact_phone_number, contact_id: 1, phone_number_id: 1))
      assert changeset.valid?
    end

    test "contact_id: if changeset has nil contact_id" do
      changeset = ContactPhoneNumber.changeset(build(:contact_phone_number, contact_id: nil, contact: nil))
      refute changeset.valid?
      assert {:contact_id, {"can't be blank", []}} in changeset.errors
    end

    test "contact_id: if changeset refers to a non-existent contact_id" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (phone_number)
      changeset = ContactPhoneNumber.changeset(build(:contact_phone_number, contact_id: -123, contact: nil, phone_number_id: 1, phone_number: nil))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:contact_id, {"does not exist", []}} in changeset.errors
    end

    test "phone_number_id: if changeset has nil phone_number_id" do
      changeset = ContactPhoneNumber.changeset(build(:contact_phone_number, phone_number_id: nil, phone_number: nil))
      refute changeset.valid?
      assert {:phone_number_id, {"can't be blank", []}} in changeset.errors
    end

    test "phone_number_id: if changeset refers to a non-existent phone_number_id" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (contact)
      changeset = ContactPhoneNumber.changeset(build(:contact_phone_number, phone_number_id: -123, phone_number: nil, contact_id: 1, contact: nil))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:phone_number_id, {"does not exist", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to contact"

    @tag :skip
    test "belongs to phone_number"
  end
end
