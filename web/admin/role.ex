defmodule ContactDemo.ExAdmin.Role do
  use ExAdmin.Register

  alias ContactDemo.AdminView
  alias Phoenix.View

  register_resource ContactDemo.Role do
    sidebar "ExAdmin Demo", only: [:index, :show] do
      View.render AdminView, "sidebar_links.html", [model: "role"]
    end
  end
end
