defmodule NobankWeb.ErrorJSON do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on JSON requests.

  See config/config.exs.
  """

  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def error(%{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  def error(%{status: :bad_request}), do: %{status: 400, error: "Bad Request"}
  def error(%{status: :unauthorized}), do: %{status: 401, error: "Unauthorized"}
  def error(%{status: :not_found, path: path}), do: %{status: 404, error: "Not Found", path: path}
  def error(%{status: :not_found}), do: %{status: 404, error: "Not Found"}
  def error(%{status: :unprocessable_entity}), do: %{status: 422, error: "Unprocessable Entity"}
  def error(%{status: :internal_server_error}), do: %{status: 500, error: "Internal Server Error"}

  defp translate_error({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end
end
