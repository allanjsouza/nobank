defmodule Nobank.Accounts.Transaction do
  alias Ecto.Multi
  alias Nobank.Accounts.Account
  alias Nobank.Repo

  def call(%{"from_account_id" => from_acc_id, "to_account_id" => to_acc_id, "value" => value}) do
    with true <- from_acc_id != to_acc_id,
         {:ok, %Money{}} <- Money.parse(value),
         %Account{} = from_account <- Repo.get(Account, from_acc_id),
         %Account{} = to_account <- Repo.get(Account, to_acc_id) do
      Multi.new()
      |> Multi.update(:withdraw, withdraw_changeset(from_account, value))
      |> Multi.update(:deposit, deposit_changeset(to_account, value))
      |> Repo.transact()
      |> handle_transaction()
    else
      false -> {:error, :unprocessable_entity}
      :error -> {:error, :unprocessable_entity}
      nil -> {:error, :not_found}
    end
  end

  def call(_), do: {:error, :bad_request}

  defp withdraw_changeset(from_account, value),
    do: Account.changeset(from_account, %{balance: Money.subtract(from_account.balance, value)})

  defp deposit_changeset(to_account, value),
    do: Account.changeset(to_account, %{balance: Money.add(to_account.balance, value)})

  defp handle_transaction({:ok, _result} = result), do: result
  defp handle_transaction({:error, _op, reason, _}), do: {:error, reason}
end
