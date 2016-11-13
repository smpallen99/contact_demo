defmodule ContactDemo.ContactPhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactPhoneNumber

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, params_with_assocs(:contact_phone_number))
      assert changeset.valid?
    end

    test "contact_id: if changeset has nil contact_id" do
      changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, Map.merge(params_with_assocs(:contact_phone_number), %{contact_id: nil}))
      refute changeset.valid?
      assert {:contact_id, {"can't be blank", []}} in changeset.errors
    end

    test "contact_id: if changeset refers to a non-existent contact_id" do
      changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, Map.merge(params_with_assocs(:contact_phone_number), %{contact_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:contact, {"does not exist", []}} in changeset.errors
    end

    test "phone_number_id: if changeset has nil phone_number_id" do
      changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, Map.merge(params_with_assocs(:contact_phone_number), %{phone_number_id: nil}))
      refute changeset.valid?
      assert {:phone_number_id, {"can't be blank", []}} in changeset.errors
    end

    test "phone_number_id: if changeset refers to a non-existent phone_number_id" do
      changeset = ContactPhoneNumber.changeset(%ContactPhoneNumber{}, Map.merge(params_with_assocs(:contact_phone_number), %{phone_number_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:phone_number, {"does not exist", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to contact"

    @tag :skip
    test "belongs to phone_number"
  end
end
