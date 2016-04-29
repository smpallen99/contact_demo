ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Nested.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Nested.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Nested.Repo)

