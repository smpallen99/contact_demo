defmodule ContactDemo.Repo.Migrations.AddCoherenceToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
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
    end
  end
end
