defmodule Nobank.Users.Update do
  alias Nobank.Repo
  alias Nobank.Users.User

  def call(id, params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
