defmodule ContactDemo.RoleControllerTest do
  use ContactDemo.ConnCase

  alias ContactDemo.Role
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, role_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing roles"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, role_path(conn, :new)
    assert html_response(conn, 200) =~ "New role"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, role_path(conn, :create), role: @valid_attrs
    assert redirected_to(conn) == role_path(conn, :index)
    assert Repo.get_by(Role, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, role_path(conn, :create), role: @invalid_attrs
    assert html_response(conn, 200) =~ "New role"
  end

  test "shows chosen resource", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = get conn, role_path(conn, :show, role)
    assert html_response(conn, 200) =~ "Show role"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, role_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = get conn, role_path(conn, :edit, role)
    assert html_response(conn, 200) =~ "Edit role"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = put conn, role_path(conn, :update, role), role: @valid_attrs
    assert redirected_to(conn) == role_path(conn, :show, role)
    assert Repo.get_by(Role, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = put conn, role_path(conn, :update, role), role: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit role"
  end

  test "deletes chosen resource", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = delete conn, role_path(conn, :delete, role)
    assert redirected_to(conn) == role_path(conn, :index)
    refute Repo.get(Role, role.id)
  end
end
