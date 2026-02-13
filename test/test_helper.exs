Mox.defmock(Nobank.ViaCep.ApiMock, for: Nobank.ViaCep.ApiBehaviour)
Application.put_env(:nobank, :via_cep_api, Nobank.ViaCep.ApiMock)

{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Nobank.Repo, :manual)
