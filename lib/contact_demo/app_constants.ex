defmodule ContactDemo.AppConstants do
  @name_format ~r/^[a-z]+[\s\'a-z]*$/i
  @username_format ~r/^[a-z]+[\s\.\'a-z]*$/i
  @email_format ~r/^[A-Z0-9._%+-]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i

  def name_format, do: @name_format

  def username_format, do: @username_format

  def email_format, do: @email_format
end
