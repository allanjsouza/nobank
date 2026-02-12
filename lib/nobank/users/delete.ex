defmodule Nobank.Users.Delete do
  alias Nobank.Repo
  alias Nobank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
