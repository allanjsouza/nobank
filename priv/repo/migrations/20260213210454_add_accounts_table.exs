defmodule Nobank.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :balance, :money_with_currency
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:accounts, [:user_id])
    create constraint(:accounts, :balance_must_be_non_negative, check: "(balance).amount >= 0")
  end
end
