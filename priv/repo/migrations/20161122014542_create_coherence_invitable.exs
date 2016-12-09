defmodule ContactDemo.Repo.Migrations.CreateCoherenceInvitable do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :token, :string, null: false

      timestamps
    end

    create index(:invitations, ["LOWER(email)"], unique: true, name: :invitations_email_index)
    create index(:invitations, [:token])
  end
end
