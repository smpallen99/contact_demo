defmodule Nested.ExAdmin.User do
  use ExAdmin.Register

  register_resource Nested.User do
    index do
      selectable_column

      column :name
      column :email
      column :active

      actions
    end

    show user do
      attributes_table do
        row :name
        row :email
        row :active
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
        input user, :name
        input user, :email
        input user, :active
        input user, :expire_on
        input user, :updated_at
        # input user, :password, type: :password
        # input user, :password_confirmation, type: :password
      end

      inputs "Roles" do
        inputs :roles, as: :check_boxes, collection: Nested.Role.all
      end

    end

    query do
      %{all: [preload: [:roles]]}
    end

  end
end
