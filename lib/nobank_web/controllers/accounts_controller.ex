defmodule NobankWeb.AccountsController do
  use NobankWeb, :controller
  alias Nobank.Accounts
  alias Nobank.Accounts.Account

  action_fallback NobankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end
end
