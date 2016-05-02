defmodule ContactDemo.Repo do
  use Ecto.Repo, otp_app: :contact_demo
  use Scrivener, page_size: 10
end
