ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ContactDemo.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ContactDemo.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ContactDemo.Repo)

