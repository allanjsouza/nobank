defmodule Nobank.Users.GetBy do
  alias Nobank.Repo
  alias Nobank.Users.User

  def call(clauses) do
    case Repo.get_by(User, clauses) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
