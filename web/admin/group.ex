defmodule Nested.ExAdmin.Group do
  use ExAdmin.Register

  register_resource Nested.Group do

    index do
      selectable_column
      column :name
      actions
    end

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
          column :name, fn(contact) ->
            text "#{contact.first_name} #{contact.last_name}"
          end
          # column :phone_numbers, fn(contact) ->
          #   UcxNotifier.PhoneNumber.format_phone_numbers_abbriviated(contact.phone_numbers)
          # end
        end
      end
    end

    query do
      # %{show: [preload: [:recordings, contacts: [:phone_numbers]]] }
      %{show: [preload: [:contacts]] }
    end
  end
end
