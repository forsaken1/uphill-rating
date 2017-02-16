ExUnit.start

Mix.Task.run "ecto.create", ~w(-r UphillRating.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r UphillRating.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(UphillRating.Repo, :manual)

