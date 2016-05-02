defmodule ContactDemo.Repo.Migrations.AddExpireToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :expire_on, :date
      add :active, :boolean
    end
  end
end
