defmodule ContactDemo.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      timestamps
    end
  end
end
