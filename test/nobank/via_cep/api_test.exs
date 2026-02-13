defmodule Nobank.ViaCep.ApiTest do
  @moduledoc false
  use ExUnit.Case, async: true

  import Nobank.ViaCep.ApiFactory

  alias Nobank.ViaCep.Api

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "get/1" do
    test "successfully responds with postal code info", %{bypass: bypass} do
      postal_code = "11000000"

      Bypass.expect_once(bypass, "GET", "/#{postal_code}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, build(:get_response, %{"cep" => postal_code}))
      end)

      expected_response = %{
        "bairro" => "bairro_fixture",
        "cep" => postal_code,
        "complemento" => "",
        "ddd" => "ddd_fixture",
        "estado" => "estado_fixture",
        "gia" => "",
        "ibge" => "ibge_fixture",
        "localidade" => "localidade_fixture",
        "logradouro" => "logradouro_fixture",
        "regiao" => "regiao_fixture",
        "siafi" => "siafi_fixture",
        "uf" => "uf_fixture",
        "unidade" => ""
      }

      assert {:ok, expected_response} == Api.get(endpoint_url(bypass.port), postal_code)
    end

    test "when gets 400 and html body returns bad_request", %{bypass: bypass} do
      postal_code = "0"

      Bypass.expect_once(bypass, "GET", "/#{postal_code}/json", fn conn ->
        Plug.Conn.resp(conn, 400, build(:bad_request_html_response))
      end)

      expected_response = {:error, :bad_request}
      assert expected_response == Api.get(endpoint_url(bypass.port), postal_code)
    end

    test "when gets 200 and 'erro=true' body returns unprocessable_entity", %{bypass: bypass} do
      postal_code = "00000000"

      Bypass.expect_once(bypass, "GET", "/#{postal_code}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, build(:erro_true_response))
      end)

      expected_response = {:error, :unprocessable_entity}
      assert expected_response == Api.get(endpoint_url(bypass.port), postal_code)
    end

    test "when API is down returns error and reason", %{bypass: bypass} do
      postal_code = "11000000"

      Bypass.down(bypass)

      expected_response = {:error, :econnrefused}
      assert expected_response == Api.get(endpoint_url(bypass.port), postal_code)
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
