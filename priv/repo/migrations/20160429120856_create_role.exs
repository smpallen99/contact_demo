defmodule ContactDemo.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, null: false

      timestamps
    end

    create index(:roles, ["LOWER(name)"], unique: true, name: :roles_name_index)

    flush

    ~w(Admin Manager User)
    |> Enum.each(fn(name) ->
      execute "INSERT INTO roles (name, inserted_at, updated_at) VALUES ('#{name}', now(), now());"
    end)
  end
end
