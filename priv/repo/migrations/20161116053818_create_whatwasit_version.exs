defmodule ContactDemo.Repo.Migrations.CreateWhatwasitVersion do
  use Ecto.Migration

  def change do
    create table(:versions) do
      add :item_type, :string, null: false
      add :item_id, :integer, null: false
      add :action, :string
      add :object, :map, null: false
      add :whodoneit_name, :string
      add :whodoneit_id, references(:users, on_delete: :nilify_all)

      timestamps
    end
  end
end
