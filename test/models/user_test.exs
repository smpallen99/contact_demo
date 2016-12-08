defmodule ContactDemo.UserTest do
  use ContactDemo.ModelCase

  alias ContactDemo.{User, UserRole}

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, params_with_assocs(:user))
      assert changeset.valid?
    end

    test "name: if changeset has nil name" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: nil}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has zero-length name" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: ""}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: if changeset has blank name" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: " "}))
      refute changeset.valid?
      assert {:name, {"can't be blank", []}} in changeset.errors
    end

    test "name: raises a validation error if the length of the text is > 255 characters" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: Lorem.words(256)}))
      refute changeset.valid?
      assert {:name, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    test "name: should be invalid when name is only numbers" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: "678"}))
      refute changeset.valid?
      assert {:name, {"has invalid format", []}} in changeset.errors
    end

    test "name: should be invalid when name starts with space" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: " space"}))
      refute changeset.valid?
      assert {:name, {"has invalid format", []}} in changeset.errors
    end

    test "email: if changeset has nil email" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: nil}))
      refute changeset.valid?
      assert {:email, {"can't be blank", []}} in changeset.errors
    end

    test "email: if changeset has zero-length email" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: ""}))
      refute changeset.valid?
      assert {:email, {"can't be blank", []}} in changeset.errors
    end

    test "email: if changeset has blank email" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: " "}))
      refute changeset.valid?
      assert {:email, {"can't be blank", []}} in changeset.errors
    end

    test "email: raises a validation error if the length of the text is > 255 characters" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: Lorem.words(256)}))
      refute changeset.valid?
      assert {:email, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    test "email: should be invalid when email is only numbers" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: "678"}))
      refute changeset.valid?
      assert {:email, {"has invalid format", []}} in changeset.errors
    end

    test "email: should be invalid when email starts with space" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: " space"}))
      refute changeset.valid?
      assert {:email, {"has invalid format", []}} in changeset.errors
    end

    test "email: should be valid when in correct format" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: "a@b.com"}))
      assert changeset.valid?
    end

    test "username: if changeset has nil username" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: nil}))
      refute changeset.valid?
      assert {:username, {"can't be blank", []}} in changeset.errors
    end

    test "username: if changeset has zero-length username" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: ""}))
      refute changeset.valid?
      assert {:username, {"can't be blank", []}} in changeset.errors
    end

    test "username: if changeset has blank username" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: " "}))
      refute changeset.valid?
      assert {:username, {"can't be blank", []}} in changeset.errors
    end

    test "username: raises a validation error if the length of the text is > 255 characters" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: Lorem.words(256)}))
      refute changeset.valid?
      assert {:username, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    test "username: should be invalid when username is only numbers" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: "678"}))
      refute changeset.valid?
      assert {:username, {"has invalid format", []}} in changeset.errors
    end

    test "username: should be invalid when username starts with space" do
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: " space"}))
      refute changeset.valid?
      assert {:username, {"has invalid format", []}} in changeset.errors
    end

    test "validates uniqueness of 'email' field" do
      original_user = insert(:user)
      duplicate_user = User.changeset(%User{}, params_with_assocs(:user, email: original_user.email))
      {:error, changeset} = Repo.insert duplicate_user
      assert {:email, {"has already been taken", []}} in changeset.errors
    end

    test "validates uniqueness of 'username' field" do
      original_user = insert(:user)
      duplicate_user = User.changeset(%User{}, params_with_assocs(:user, username: original_user.username))
      {:error, changeset} = Repo.insert duplicate_user
      assert {:username, {"has already been taken", []}} in changeset.errors
    end
  end

  test "populates the 'encrypted_password' field when inserting" do
    changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{password: "secret", password_confirmation: "secret"}))
    user = Repo.insert! changeset
    assert User.checkpw("secret", user.encrypted_password)
  end

  describe "relationships" do
    @tag :skip
    test "has many users_roles"

    @tag :skip
    test "has many roles through users_roles"
  end

  describe "has_role?" do
    test "returns true when role_name is an atom and matches" do
      role = insert(:role, name: "some")

      user = insert(:user)
      %UserRole{user: user, role: role} |> Repo.insert!

      assert(User.has_role?(user, :some) == true)
    end

    test "returns true when role_name is a string and matches" do
      role = insert(:role, name: "some")

      user = insert(:user)
      %UserRole{user: user, role: role} |> Repo.insert!

      assert(User.has_role?(user, "some") == true)
    end

    test "when db-role is in a different case than parameter-role name" do
      role = insert(:role, name: "SOME")

      user = insert(:user)
      %UserRole{user: user, role: role} |> Repo.insert!

      assert(User.has_role?(user, :some) == true)
    end

    test "when db-role contains but does not match the parameter-role name" do
      role = insert(:role, name: "AWESOMELY")

      user = insert(:user)
      %UserRole{user: user, role: role} |> Repo.insert!

      assert(User.has_role?(user, :some) == false)
    end

    test "when db-role has leading/trailing spaces when compared to the parameter-role name" do
      role = insert(:role, name: "  SOME  ")

      user = insert(:user)
      %UserRole{user: user, role: role} |> Repo.insert!

      assert(User.has_role?(user, :some) == false)
    end
  end
end
