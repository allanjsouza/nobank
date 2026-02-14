defmodule Nobank.Accounts do
  alias Nobank.Accounts

  defdelegate create(params), to: Accounts.Create, as: :call
end
