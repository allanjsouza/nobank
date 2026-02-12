defmodule Nobank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @required_params [:name, :password, :email, :postal_code]
  @w3c_email_regex ~r/^[[:alnum:].!#$%&'*+\/=?^_`{|}~-]+@[[:alnum:]-]+(?:\.[[:alnum:]-]+)*$/

  # Another way to show a user (instead of `data` function on `NobankWeb.UsersJSON` module)
  # @derive {Jason.Encoder, only: [:name, :email, :postal_code]}
  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :postal_code, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, @w3c_email_regex)
    |> validate_format(:postal_code, ~r/^[[:digit:]]+$/)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: pwd}} = changeset) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pwd))
  end

  defp put_password_hash(changeset), do: changeset
end
