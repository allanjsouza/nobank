defmodule Nobank.Accounts.Transaction do
  alias Ecto.Multi
  alias Nobank.Accounts.Account
  alias Nobank.Repo

  def call(%{"from_account_id" => from_acc_id, "to_account_id" => to_acc_id, "value" => value}) do
    with :ok <- validate_different_accounts(from_acc_id, to_acc_id),
         :ok <- validate_transaction_value(value),
         %Account{} = from_account <- get_account(from_acc_id),
         %Account{} = to_account <- get_account(to_acc_id) do
      Multi.new()
      |> Multi.update(:withdraw, withdraw_changeset(from_account, value))
      |> Multi.update(:deposit, deposit_changeset(to_account, value))
      |> Repo.transact()
      |> handle_transaction()
    end
  end

  def call(_), do: {:error, :bad_request}

  defp validate_different_accounts(from_account_id, to_account_id) do
    case from_account_id != to_account_id do
      true -> :ok
      false -> {:error, :unprocessable_entity}
    end
  end

  defp validate_transaction_value(value) do
    case Money.parse(value) do
      {:ok, %Money{}} -> :ok
      :error -> {:error, :unprocessable_entity}
    end
  end

  defp get_account(account_id) do
    case Repo.get(Account, account_id) do
      nil -> {:error, :not_found}
      account -> account
    end
  end

  defp withdraw_changeset(from_account, value),
    do: Account.changeset(from_account, %{balance: Money.subtract(from_account.balance, value)})

  defp deposit_changeset(to_account, value),
    do: Account.changeset(to_account, %{balance: Money.add(to_account.balance, value)})

  defp handle_transaction({:ok, _result} = result), do: result
  defp handle_transaction({:error, _op, reason, _}), do: {:error, reason}
end
