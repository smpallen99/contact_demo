defmodule ContactDemo.Repo.Migrations.CreateUserRole do
  use Ecto.Migration

  import Ecto.Query
  alias ContactDemo.{Repo, Role, User}

  def change do
    create table(:users_roles) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :role_id, references(:roles, on_delete: :delete_all), null: false

      timestamps
    end

    create index(:users_roles, [:user_id])
    create index(:users_roles, [:role_id])

    flush

    [
      %{user: "demo-admin", role: Role.admin},
      %{user: "demo-manager", role: Role.manager},
      %{user: "demo-user", role: Role.user}
    ]
    |> Enum.each(fn(%{user: user, role: role}) ->
      user_id = (from u in User, where: u.username == ^user, select: u.id) |> Repo.one
      role_id = (from r in Role, where: fragment("LOWER(?)", r.name) == fragment("LOWER(?)", ^role), select: r.id) |> Repo.one

      execute "INSERT INTO users_roles (user_id, role_id, inserted_at, updated_at) VALUES ('#{user_id}', '#{role_id}', now(), now());"
    end)
  end
end
