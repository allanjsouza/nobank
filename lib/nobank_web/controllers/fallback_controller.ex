defmodule NobankWeb.FallbackController do
  use NobankWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, status: :not_found, path: conn.request_path)
  end

  def call(conn, {:error, :unprocessable_entity}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: NobankWeb.ErrorJSON)
    |> render(:error, status: :unprocessable_entity)
  end
end
