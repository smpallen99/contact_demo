defmodule ContactDemo.ContactTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Contact

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Contact.changeset(%Contact{}, params_with_assocs(:contact))
      assert changeset.valid?
    end

    test "first_name: if changeset has nil first_name" do
      changeset = Contact.changeset(%Contact{}, Map.merge(params_with_assocs(:contact), %{first_name: nil}))
      refute changeset.valid?
      assert {:first_name, {"can't be blank", []}} in changeset.errors
    end

    test "first_name: if changeset has zero-length first_name" do
      changeset = Contact.changeset(%Contact{}, Map.merge(params_with_assocs(:contact), %{first_name: ""}))
      refute changeset.valid?
      assert {:first_name, {"can't be blank", []}} in changeset.errors
    end

    test "first_name: if changeset has blank first_name" do
      changeset = Contact.changeset(%Contact{}, Map.merge(params_with_assocs(:contact), %{first_name: " "}))
      refute changeset.valid?
      assert {:first_name, {"can't be blank", []}} in changeset.errors
    end

    test "category_id: if changeset has nil category_id" do
      changeset = Contact.changeset(%Contact{}, Map.merge(params_with_assocs(:contact), %{category_id: nil}))
      refute changeset.valid?
      assert {:category_id, {"can't be blank", []}} in changeset.errors
    end

    test "category_id: if changeset refers to a non-existent category_id" do
      changeset = Contact.changeset(%Contact{}, Map.merge(params_with_assocs(:contact), %{category_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:category, {"does not exist", []}} in changeset.errors
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
