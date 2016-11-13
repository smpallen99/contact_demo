defmodule ContactDemo.ContactGroupTest do
  use ContactDemo.ModelCase

  alias ContactDemo.ContactGroup

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = ContactGroup.changeset(%ContactGroup{}, params_with_assocs(:contact_group))
      assert changeset.valid?
    end

    test "contact_id: if changeset has nil contact_id" do
      changeset = ContactGroup.changeset(%ContactGroup{}, Map.merge(params_with_assocs(:contact_group), %{contact_id: nil}))
      refute changeset.valid?
      assert {:contact_id, {"can't be blank", []}} in changeset.errors
    end

    test "contact_id: if changeset refers to a non-existent contact_id" do
      changeset = ContactGroup.changeset(%ContactGroup{}, Map.merge(params_with_assocs(:contact_group), %{contact_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:contact, {"does not exist", []}} in changeset.errors
    end

    test "group_id: if changeset has nil group_id" do
      changeset = ContactGroup.changeset(%ContactGroup{}, Map.merge(params_with_assocs(:contact_group), %{group_id: nil, group: nil}))
      refute changeset.valid?
      assert {:group_id, {"can't be blank", []}} in changeset.errors
    end

    test "group_id: if changeset refers to a non-existent group_id" do
      changeset = ContactGroup.changeset(%ContactGroup{}, Map.merge(params_with_assocs(:contact_group), %{group_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:group, {"does not exist", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to contact"

    @tag :skip
    test "belongs to group"
  end
end
