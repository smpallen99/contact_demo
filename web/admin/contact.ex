defmodule ContactDemo.ExAdmin.Contact do
  use ExAdmin.Register

  register_resource ContactDemo.Contact do

    form contact do
      inputs do
        input contact, :first_name
        input contact, :last_name
        input contact, :email
        input contact, :category, collection: ContactDemo.Category.all
      end

      inputs "Phone Numbers" do
        has_many contact, :phone_numbers, fn(p) ->
          input p, :label, collection: ContactDemo.PhoneNumber.labels
          input p, :number
        end
      end

      inputs "Groups" do
        inputs :groups, as: :check_boxes, collection: ContactDemo.Group.all
      end
    end

    index do
      selectable_column

      column :first_name
      column :last_name
      column :email
      column :category
      column :phone_numbers, fn(contact) ->
        text ContactDemo.PhoneNumber.format_phone_numbers_abbriviated(contact.phone_numbers)
      end
      actions
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
      Phoenix.View.render ContactDemo.AdminView, "sidebar_links.html", [model: "contact"]
    end
  end
end
