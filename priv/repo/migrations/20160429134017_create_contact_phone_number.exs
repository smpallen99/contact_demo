defmodule ContactDemo.Repo.Migrations.CreateContactPhoneNumber do
  use Ecto.Migration

  def change do
    create table(:contacts_phone_numbers) do
      add :contact_id, references(:contacts, on_delete: :delete_all), null: false
      add :phone_number_id, references(:phone_numbers, on_delete: :delete_all), null: false

      timestamps
    end

    create index(:contacts_phone_numbers, [:contact_id])
    create index(:contacts_phone_numbers, [:phone_number_id])
  end
end
