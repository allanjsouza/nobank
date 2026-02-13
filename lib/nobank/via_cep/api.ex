defmodule Nobank.ViaCep.Api do
  alias Nobank.ViaCep.ApiBehaviour

  @base_url "https://viacep.com.br/ws"

  @behaviour ApiBehaviour

  @impl ApiBehaviour
  def get(base_url \\ @base_url, postal_code) do
    base_url
    |> client()
    |> Tesla.get("/#{postal_code}/json")
    |> handle_response()
  end

  defp client(base_url) do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, base_url},
      Tesla.Middleware.JSON
    ])
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}),
    do: {:error, :unprocessable_entity}

  defp handle_response({:ok, %Tesla.Env{status: 200, body: response_body}}),
    do: {:ok, response_body}

  defp handle_response({:ok, %Tesla.Env{status: 400}}),
    do: {:error, :bad_request}

  defp handle_response({:error, {reason}}), do: {:error, reason}
  defp handle_response({:error, _reason} = error), do: error
end
