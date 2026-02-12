defmodule NobankWeb.UsersController do
  use NobankWeb, :controller
  alias Nobank.Users.Create

  def create(conn, params) do
    params
    |> Create.call()
    |> handle_create(conn)
  end

  defp handle_create({:ok, user}, conn) do
    conn
    |> put_status(:created)
    |> render(:create, user: user)
  end

  defp handle_create({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
