defmodule ContactDemo.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false
      add :expire_on, :date
      add :active, :boolean, null: false, default: true
      add :username, :string, null: false

      timestamps
    end

    create index(:users, ["LOWER(email)"], unique: true, name: :users_email_index)
    create index(:users, ["LOWER(username)"], unique: true, name: :users_username_index)
  end
end
