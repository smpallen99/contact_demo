{:ok, _} = Application.ensure_all_started(:ex_machina)

Application.ensure_all_started(:hound)

ExUnit.start

ContactDemo.Repo.__adapter__.storage_down ContactDemo.Repo.config
ContactDemo.Repo.__adapter__.storage_up ContactDemo.Repo.config

Ecto.Adapters.SQL.Sandbox.mode(ContactDemo.Repo, :manual)
