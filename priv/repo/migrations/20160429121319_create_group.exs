defmodule ContactDemo.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string, null: false

      timestamps
    end

    create index(:groups, ["LOWER(name)"], unique: true, name: :groups_name_index)
  end
end
