defmodule NobankWeb.AccountsJSON do
  alias Nobank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Account created successfully",
      data: data(account)
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      user_id: account.user_id,
      balance: Money.to_string(account.balance, code: true)
    }
  end
end
