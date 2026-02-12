defmodule Nobank.Users.Create do
  alias Nobank.Repo
  alias Nobank.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
