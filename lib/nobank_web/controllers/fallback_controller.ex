defmodule NobankWeb.FallbackController do
  use NobankWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
