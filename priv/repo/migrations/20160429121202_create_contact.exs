defmodule ContactDemo.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps
    end

    create index(:contacts, [:category_id])
  end
end
