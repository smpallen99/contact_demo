defmodule ContactDemo.UserTest do
  use ContactDemo.ModelCase

  alias ContactDemo.User

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
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{name: Faker.Lorem.words(256)}))
      refute changeset.valid?
      assert {:name, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
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
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{email: Faker.Lorem.words(256)}))
      refute changeset.valid?
      assert {:email, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
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
      changeset = User.changeset(%User{}, Map.merge(params_with_assocs(:user), %{username: Faker.Lorem.words(256)}))
      refute changeset.valid?
      assert {:username, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    @tag :skip
    test "validates format of 'email' field"

    @tag :skip
    test "validates uniqueness of 'email' field"

    @tag :skip
    test "validates uniqueness of 'username' field"
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
end
