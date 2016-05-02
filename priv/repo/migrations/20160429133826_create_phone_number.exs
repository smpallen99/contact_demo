defmodule ContactDemo.Repo.Migrations.CreatePhoneNumber do
  use Ecto.Migration

  def change do
    create table(:phone_numbers) do
      add :number, :string
      add :kind, :string
      add :label, :string

      timestamps
    end

  end
end
