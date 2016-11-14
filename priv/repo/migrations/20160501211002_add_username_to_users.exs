defmodule ContactDemo.Repo.Migrations.AddUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: false
    end

    create index(:users, ["LOWER(username)"], unique: true, name: :users_username_index)
  end
end
