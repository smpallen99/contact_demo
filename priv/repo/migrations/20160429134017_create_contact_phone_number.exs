defmodule Nested.Repo.Migrations.CreateContactPhoneNumber do
  use Ecto.Migration

  def change do
    create table(:contacts_phone_numbers) do
      add :contact_id, references(:contacts, on_delete: :nothing)
      add :phone_number_id, references(:phone_numbers, on_delete: :nothing)

      timestamps
    end
    create index(:contacts_phone_numbers, [:contact_id])
    create index(:contacts_phone_numbers, [:phone_number_id])

  end
end
