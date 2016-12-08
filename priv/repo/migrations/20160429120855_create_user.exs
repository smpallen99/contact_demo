defmodule ContactDemo.Repo.Migrations.CreateUser do
  use Ecto.Migration
  alias ContactDemo.User

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false
      add :expire_on, :date
      add :active, :boolean, null: false, default: true
      add :username, :string, null: false

      # confirmable
      add :confirmation_token, :string
      add :confirmed_at, :datetime
      add :confirmation_sent_at, :datetime
      # unlockable_with_token
      add :unlock_token, :string
      # authenticatable
      # add :encrypted_password, :string
      # trackable
      add :sign_in_count, :integer, default: 0
      add :current_sign_in_at, :datetime
      add :last_sign_in_at, :datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string
      # lockable
      add :failed_attempts, :integer, default: 0
      add :locked_at, :datetime
      # recoverable
      add :reset_password_token, :string
      add :reset_password_sent_at, :datetime
      # rememberable
      add :remember_created_at, :datetime

      timestamps
    end

    create index(:users, ["LOWER(email)"], unique: true, name: :users_email_index)
    create index(:users, ["LOWER(username)"], unique: true, name: :users_username_index)

    flush

    name = "Demo User"
    email = "demouser@example.com"
    username = "demouser"
    encrypted_password = User.encrypt_password("secret")
    execute "INSERT INTO users (name, email, encrypted_password, active, username, confirmed_at, inserted_at, updated_at) VALUES ('#{name}', '#{email}', '#{encrypted_password}', #{true}, '#{username}', now(), now(), now());"
  end
end
