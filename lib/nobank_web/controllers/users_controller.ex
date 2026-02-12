defmodule NobankWeb.UsersController do
  use NobankWeb, :controller
  alias Nobank.Users
  alias Nobank.Users.User

  action_fallback NobankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.show(id) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end
end
