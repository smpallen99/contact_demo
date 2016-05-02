defmodule ContactDemo.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :position, :integer

      timestamps
    end

  end
end
