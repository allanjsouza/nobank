defmodule Nobank.Accounts.Create do
  alias Nobank.Accounts.Account
  alias Nobank.Repo
  alias Nobank.Users
  alias Nobank.Users.User

  def call(%{"user_id" => user_id} = params) do
    with {:ok, %User{}} <- handle_get_user(user_id) do
      params
      |> Account.changeset()
      |> Repo.insert()
    end
  end

  defp handle_get_user(user_id) do
    case Users.get(user_id) do
      {:ok, %User{}} = result -> result
      {:error, :not_found} -> {:error, :unprocessable_entity}
    end
  end
end
