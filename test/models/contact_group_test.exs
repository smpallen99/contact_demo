defmodule ContactDemo.ContactGroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactGroup

  describe "validations" do
    test "changeset with valid attributes" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (contact, group)
      changeset = ContactGroup.changeset(build(:contact_group, contact_id: 1, group_id: 1))
      assert changeset.valid?
    end

    test "contact_id: if changeset has nil contact_id" do
      changeset = ContactGroup.changeset(build(:contact_group, contact_id: nil, contact: nil))
      refute changeset.valid?
      assert {:contact_id, {"can't be blank", []}} in changeset.errors
    end

    test "contact_id: if changeset refers to a non-existent contact_id" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (group)
      changeset = ContactGroup.changeset(build(:contact_group, contact_id: -123, contact: nil, group_id: 1, group: nil))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:contact_id, {"does not exist", []}} in changeset.errors
    end

    test "group_id: if changeset has nil group_id" do
      changeset = ContactGroup.changeset(build(:contact_group, group_id: nil, group: nil))
      refute changeset.valid?
      assert {:group_id, {"can't be blank", []}} in changeset.errors
    end

    test "group_id: if changeset refers to a non-existent group_id" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (contact)
      changeset = ContactGroup.changeset(build(:contact_group, group_id: -123, group: nil, contact_id: 1, contact: nil))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:group_id, {"does not exist", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to contact"

    @tag :skip
    test "belongs to group"
  end
end
