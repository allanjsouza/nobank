defmodule Nobank.Users do
  alias Nobank.Users
  alias Nobank.Users.VerifyPassword

  defdelegate create(params), to: Users.Create, as: :call
  defdelegate get(id), to: Users.Get, as: :call
  defdelegate get_by(clauses), to: Users.GetBy, as: :call
  defdelegate update(id, params), to: Users.Update, as: :call
  defdelegate delete(id), to: Users.Delete, as: :call
  defdelegate login(params), to: VerifyPassword, as: :call
end
