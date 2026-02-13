defmodule Nobank.Users.Create do
  alias Nobank.Repo
  alias Nobank.Users.User
  alias Nobank.ViaCep.Api, as: ViaCepApi

  def call(%{"postal_code" => postal_code} = params) do
    with {:ok, _response} <- ViaCepApi.get(postal_code) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
