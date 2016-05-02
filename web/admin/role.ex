defmodule ContactDemo.ExAdmin.Role do
  use ExAdmin.Register

  register_resource ContactDemo.Role do

    sidebar "ExAdmin Demo", only: [:index, :show] do
      Phoenix.View.render ContactDemo.AdminView, "sidebar_links.html", [model: "role"]
    end
  end
end
