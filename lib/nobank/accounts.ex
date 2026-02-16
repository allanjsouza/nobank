defmodule Nobank.Accounts do
  alias Nobank.Accounts
  alias Nobank.Accounts.Transaction

  defdelegate create(params), to: Accounts.Create, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
