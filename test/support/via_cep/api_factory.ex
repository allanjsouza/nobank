defmodule Nobank.ViaCep.ApiFactory do
  use ExMachina

  def get_response_factory(attrs \\ %{}) do
    ~s"""
    {
    "bairro": "bairro_fixture",
    "cep": "#{Map.get(attrs, "cep", "cep_fixture")}",
    "complemento": "",
    "ddd": "ddd_fixture",
    "estado": "estado_fixture",
    "gia": "",
    "ibge": "ibge_fixture",
    "localidade": "localidade_fixture",
    "logradouro": "logradouro_fixture",
    "regiao": "regiao_fixture",
    "siafi": "siafi_fixture",
    "uf": "uf_fixture",
    "unidade": ""
    }
    """
  end

  def bad_request_html_response_factory(_attrs) do
    ~s"""
    <!DOCTYPE HTML>
    <html lang=\"pt-br\">

    <head>
      <title>ViaCEP 400</title>
      <meta charset=\"utf-8\" />
      <style type=\"text/css\">
        h1 {
            color: #555;
            text-align: center;
            font-size: 4em;
        }
        h2, h3 {
            color: #666;
            text-align: center;
            font-size: 3em;
        }
        h3 {
            font-size: 1.5em;
        }
      </style>
    </head>

    <body>
        <h1>Http 400</h1>
        <h3>Verifique a URL</h3>
        <h3>{Bad Request}</h3>
    </body>

    </html>
    """
  end

  def erro_true_response_factory(_attrs), do: ~s/{"erro": "true"}/
end
