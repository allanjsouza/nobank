defmodule Nobank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nobank.Users.User

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, Money.Ecto.Composite.Type
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_non_negative)
    |> unique_constraint(:user_id)
  end
end
