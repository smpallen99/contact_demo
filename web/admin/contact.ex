defmodule ContactDemo.ExAdmin.Contact do
  use ExAdmin.Register

  alias ContactDemo.{AdminView, Category, Group, PhoneNumber}
  alias Phoenix.View
  alias ContactDemo.Authorization, as: Authz

  register_resource ContactDemo.Contact do
    # TODO: Look at https://github.com/smpallen99/ex_admin/issues/232 for info about how to combine the index and csv blocks
    index do
      selectable_column

      if Authz.is_admin?(conn), do: column :first_name
      column :last_name
      column :email
      column :category
      column :phone_numbers, fn(contact) ->
        text PhoneNumber.format_phone_numbers_abbreviated(contact.phone_numbers)
      end

      actions
    end

    csv [
      :first_name,
      {"Surname", &(&1.last_name)},
      :email,
      {:category, &(&1.category.name)},
      {"Groups", &(Enum.map(&1.groups, fn g -> g.name end) |> Enum.join("; "))},
    ] ++
      (for label <- PhoneNumber.labels do
        fun = fn c ->
          c.phone_numbers
          |> PhoneNumber.find_by_label(label)
          |> Map.get(:number, "")
        end
        {label, fun}
      end)

    form contact do
      inputs do
        input contact, :first_name
        input contact, :last_name
        input contact, :email
        input contact, :category, collection: Category.all
      end

      inputs "Phone Numbers" do
        has_many contact, :phone_numbers, fn(p) ->
          input p, :label, collection: PhoneNumber.labels
          input p, :number
        end
      end

      inputs "Groups" do
        inputs :groups, as: :check_boxes, collection: Group.all
      end
    end

    show contact do
      attributes_table do
        row :first_name
        row :last_name
        row :email
        row :category
      end

      panel "Phone Numbers" do
        table_for contact.phone_numbers do
          column :label
          column :number
        end
      end

      panel "Groups" do
        table_for contact.groups do
          #column :id, link: true
          column :name, link: true
        end
      end
    end

    query do
      %{
        all: [preload: [:category, :phone_numbers, :groups]],
      }
    end

    sidebar "ExAdmin Demo", only: [:index, :show] do
      View.render AdminView, "sidebar_links.html", [model: "contact"]
    end
  end
end
