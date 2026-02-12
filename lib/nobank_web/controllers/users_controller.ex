defmodule NobankWeb.UsersController do
  use NobankWeb, :controller
  alias Nobank.Users.{Create, User}

  action_fallback NobankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
