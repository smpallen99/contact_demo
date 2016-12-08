defmodule ContactDemo.ExAdmin.Group do
  use ExAdmin.Register

  alias ContactDemo.AdminView
  alias Phoenix.View

  register_resource ContactDemo.Group do
    index do
      selectable_column
      column :name
      actions
    end

    # TODO: Need to customize the csv block

    form group do
      inputs do
        input group, :name
      end
    end

    show group do
      attributes_table do
        row :name
      end

      panel "Contacts" do
        table_for group.contacts do
          column :id, link: true
          column :name, [link: true], fn(contact) ->
            text "#{contact.first_name} #{contact.last_name}"
          end
          # column :phone_numbers, fn(contact) ->
          #   UcxNotifier.PhoneNumber.format_phone_numbers_abbreviated(contact.phone_numbers)
          # end
        end
      end
    end

    query do
      # %{show: [preload: [:recordings, contacts: [:phone_numbers]]] }
      %{show: [preload: [:contacts]]}
    end

    sidebar "ExAdmin Demo", only: [:index, :show] do
      View.render AdminView, "sidebar_links.html", [model: "group"]
    end
  end
end
