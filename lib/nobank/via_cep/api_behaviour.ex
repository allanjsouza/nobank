defmodule Nobank.ViaCep.ApiBehaviour do
  @callback get(String.t()) :: {:ok, map()} | {:error, atom()}
end
