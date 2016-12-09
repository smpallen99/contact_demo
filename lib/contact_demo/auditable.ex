defmodule ContactDemo.Auditable do
  alias ExAdmin.Utils
  alias ContactDemo.Authentication, as: Auth

  def capture_audit_settings(conn, params) do
    user = Auth.current_user(conn)
    # TODO: Not sure if injecting these into the params object is hacky or not
    new_params = params
      |> put_in([conn.assigns.defn.resource_name, :whodoneit_id], user.id)
      |> put_in([conn.assigns.defn.resource_name, :whodoneit_name], user.name)

    {conn, new_params}
  end

  def audited_changeset(model, params) do
    resource_name = Utils.resource_name(model.__struct__)
    resource_params = if Map.has_key?(params, resource_name), do: params[resource_name], else: params
    resource_params = resource_params || %{}
    {whodoneit_id, _} = Map.pop(resource_params, "whodoneit_id")
    {whodoneit_name, _} = Map.pop(resource_params, "whodoneit_name")
    model.__struct__.changeset(model, params, [whodoneit_id: whodoneit_id, whodoneit_name: whodoneit_name])
  end
end
