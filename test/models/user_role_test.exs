defmodule ContactDemo.UserRoleTest do
  use ContactDemo.ModelCase

  alias ContactDemo.UserRole

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = UserRole.changeset(%UserRole{}, params_with_assocs(:user_role))
      assert changeset.valid?
    end

    test "user_id: if changeset has nil user_id" do
      changeset = UserRole.changeset(%UserRole{}, Map.merge(params_with_assocs(:user_role), %{user_id: nil}))
      refute changeset.valid?
      assert {:user_id, {"can't be blank", []}} in changeset.errors
    end

    test "user_id: if changeset refers to a non-existent user_id" do
      changeset = UserRole.changeset(%UserRole{}, Map.merge(params_with_assocs(:user_role), %{user_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:user, {"does not exist", []}} in changeset.errors
    end

    test "role_id: if changeset has nil role_id" do
      changeset = UserRole.changeset(%UserRole{}, Map.merge(params_with_assocs(:user_role), %{role_id: nil}))
      refute changeset.valid?
      assert {:role_id, {"can't be blank", []}} in changeset.errors
    end

    test "role_id: if changeset refers to a non-existent role_id" do
      changeset = UserRole.changeset(%UserRole{}, Map.merge(params_with_assocs(:user_role), %{role_id: -123}))
      {:error, changeset} = Repo.insert changeset
      refute changeset.valid?
      assert {:role, {"does not exist", []}} in changeset.errors
    end
  end

  describe "relationships" do
    @tag :skip
    test "belongs to user"

    @tag :skip
    test "belongs to role"
  end
end
