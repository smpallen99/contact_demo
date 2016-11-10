defmodule ContactDemo.UserTest do
  use ContactDemo.ModelCase

  alias ContactDemo.User

  @valid_attrs %{email: "some@content", encrypted_password: "some content", password: "some content", password_confirmation: "some content", name: "some content", active: true, username: "testuser"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
    assert {:name, {"can't be blank", []}} in changeset.errors
  end

  test "creates with password" do
    attrs = Map.merge(@valid_attrs, %{username: "testuser2", password: "secret", password_confirmation: "secret"})
    changeset = User.changeset(%User{}, attrs)
    assert changeset.valid?
    #Repo.insert! changeset
  end

  test "validates password" do
    attrs = Map.merge(@valid_attrs, %{username: "testuser3", password: "secret", password_confirmation: "secret"})
    changeset = User.changeset(%User{}, attrs)
    user = Repo.insert! changeset
    assert User.checkpw("secret", user.encrypted_password)
  end
end
