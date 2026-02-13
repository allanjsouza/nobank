defmodule Nobank.Users.Create do
  alias Nobank.Repo
  alias Nobank.Users.User
  alias Nobank.ViaCep.Api, as: ViaCepApi

  def call(%{"postal_code" => postal_code} = params) do
    with {:ok, _response} <- via_cep_api().get(postal_code) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp via_cep_api, do: Application.get_env(:nobank, :via_cep_api, ViaCepApi)
end
