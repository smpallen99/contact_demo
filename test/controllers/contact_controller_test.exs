defmodule ContactDemo.ContactControllerTest do
  use ContactDemo.ConnCase

  alias ContactDemo.Contact

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, contact_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing contacts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, contact_path(conn, :new)
    assert html_response(conn, 200) =~ "New contact"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    valid_attrs = params_with_assocs(:contact) |> Map.take([:email, :first_name, :last_name, :category_id])
    conn = post conn, contact_path(conn, :create), contact: valid_attrs
    assert redirected_to(conn) == contact_path(conn, :index)
    assert Repo.get_by(Contact, valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, contact_path(conn, :create), contact: %{}
    assert html_response(conn, 200) =~ "New contact"
  end

  test "shows chosen resource", %{conn: conn} do
    contact = insert(:contact)
    conn = get conn, contact_path(conn, :show, contact)
    assert html_response(conn, 200) =~ "Show contact"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, contact_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    contact = insert(:contact)
    conn = get conn, contact_path(conn, :edit, contact)
    assert html_response(conn, 200) =~ "Edit contact"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    valid_attrs = params_with_assocs(:contact) |> Map.take([:email, :first_name, :last_name, :category_id])
    contact = insert(:contact)
    conn = put conn, contact_path(conn, :update, contact), contact: valid_attrs
    assert redirected_to(conn) == contact_path(conn, :show, contact)
    assert Repo.get_by(Contact, valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    contact = insert(:contact)
    conn = put conn, contact_path(conn, :update, contact), contact: %{first_name: nil}
    assert html_response(conn, 200) =~ "Edit contact"
  end

  test "deletes chosen resource", %{conn: conn} do
    contact = insert(:contact)
    conn = delete conn, contact_path(conn, :delete, contact)
    assert redirected_to(conn) == contact_path(conn, :index)
    refute Repo.get(Contact, contact.id)
  end
end
