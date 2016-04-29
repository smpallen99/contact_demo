defmodule Nested.Repo do
  use Ecto.Repo, otp_app: :nested
  use Scrivener, page_size: 10
end
