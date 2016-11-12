defmodule ContactDemo.UserRoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.UserRole

  describe "validations" do
    test "changeset with valid attributes" do
      # TODO: Need to figure out how to use the "Default" factory-generated related object (user, role)
      changeset = UserRole.changeset(build(:user_role, user_id: 1, role_id: 1))
      assert changeset.valid?
    end

    test "user_id: if changeset has nil user_id" do
      changeset = UserRole.changeset(build(:user_role, user_id: nil, user: nil, role_id: 1, role: nil))
      refute changeset.valid?
      assert {:user_id, {"can't be blank", []}} in changeset.errors
    end

    test "user_id: if changeset refers to a non-existent user_id" do
      changeset = UserRole.changeset(build(:user_role, user_id: -123, user: nil, role_id: 1, role: nil))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:user_id, {"does not exist", []}} in changeset.errors
    end

    test "role_id: if changeset has nil role_id" do
      changeset = UserRole.changeset(build(:user_role, role_id: nil, role: nil, user_id: 1, user: nil))
      refute changeset.valid?
      assert {:role_id, {"can't be blank", []}} in changeset.errors
    end

    test "role_id: if changeset refers to a non-existent role_id" do
      changeset = UserRole.changeset(build(:user_role, role_id: -123, role: nil, user_id: 1, user: nil))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:role_id, {"does not exist", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to user"

    @tag :skip
    test "belongs to role"
  end
end
