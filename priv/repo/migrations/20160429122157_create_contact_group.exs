defmodule ContactDemo.Repo.Migrations.CreateContactGroup do
  use Ecto.Migration

  def change do
    create table(:contacts_groups) do
      add :contact_id, references(:contacts, on_delete: :delete_all), null: false
      add :group_id, references(:groups, on_delete: :delete_all), null: false

      timestamps
    end

    create index(:contacts_groups, [:contact_id])
    create index(:contacts_groups, [:group_id])
  end
end
