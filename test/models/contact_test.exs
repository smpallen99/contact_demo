defmodule ContactDemo.ContactTest do
  use ContactDemo.ModelCase

  alias ContactDemo.Contact

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = Contact.changeset(build(:contact, category_id: 1))
      assert changeset.valid?
    end

    context "for first_name" do
      test "if changeset has nil first_name" do
        changeset = Contact.changeset(build(:contact, first_name: nil))
        refute changeset.valid?
        assert {:first_name, {"can't be blank", []}} in changeset.errors
      end

      test "if changeset has zero-length first_name" do
        changeset = Contact.changeset(build(:contact, first_name: ""))
        refute changeset.valid?
        assert {:first_name, {"can't be blank", []}} in changeset.errors
      end

      test "if changeset has blank first_name" do
        changeset = Contact.changeset(build(:contact, first_name: " "))
        refute changeset.valid?
        assert {:first_name, {"can't be blank", []}} in changeset.errors
      end
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
