defmodule ContactDemo.ExAdmin.User do
  use ExAdmin.Register

  alias ContactDemo.{Role, AdminView}
  alias Phoenix.View

  register_resource ContactDemo.User do
    filter except: [:encrypted_password]
    # filter only: [:name, :email]

    index do
      selectable_column

      column :username
      column :name
      column :email
      column :active, toggle: true

      actions
    end

    # TODO: Need to customize the csv block

    show user do
      attributes_table do
        row :name
        row :username
        row :email
        row :active, toggle: true
        row :expire_on
        # row "Admin", fn(u) -> "#{has_role?(u, :admin)}" end
        # row "Authentication Token", fn(u) ->
        #   unless u.authentication_token,  do: "No Token", else: u.authentication_token
        # end
      end

      panel "Roles" do
        table_for user.roles do
          column :name
        end
      end
    end

    form user do
      inputs "User Details" do
        input user, :username
        input user, :name
        input user, :email
        input user, :active
        input user, :expire_on
        # input user, :updated_at
        # input user, :password, type: :password
        # input user, :password_confirmation, type: :password
      end

      inputs "Roles" do
        inputs :roles, as: :check_boxes, collection: Role.all
      end
    end

    action_item :index, fn ->
      action_item_link "Invite Someone", href: "/invitations/new"
    end

    query do
      %{all: [preload: [:roles]]}
    end

    sidebar "ExAdmin Demo", only: [:index, :show] do
      View.render AdminView, "sidebar_links.html", [model: "user"]
    end
  end
end
