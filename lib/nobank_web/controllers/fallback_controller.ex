defmodule NobankWeb.FallbackController do
  use NobankWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found = status}), do: handle_error(conn, status)
  def call(conn, {:error, :bad_request = status}), do: handle_error(conn, status)
  def call(conn, {:error, :unprocessable_entity = status}), do: handle_error(conn, status)
  def call(conn, {:error, :internal_server_error = status}), do: handle_error(conn, status)

  def handle_error(conn, status) do
    conn
    |> put_status(status)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, status: status)
  end
end
