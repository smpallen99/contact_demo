defmodule ContactDemo.Repo.Migrations.CreateUserRole do
  use Ecto.Migration

  def change do
    create table(:users_roles) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)

      timestamps
    end

    create index(:users_roles, [:user_id])
    create index(:users_roles, [:role_id])
  end
end
