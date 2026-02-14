defmodule Nobank.Users.Get do
  alias Nobank.Repo
  alias Nobank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
