defmodule ContactDemo.Repo.Migrations.CreatePhoneNumber do
  use Ecto.Migration

  def change do
    create table(:phone_numbers) do
      add :number, :string, null: false
      add :kind, :string
      add :label, :string, null: false

      timestamps
    end
  end
end
