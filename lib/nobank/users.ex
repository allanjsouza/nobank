defmodule Nobank.Users do
  alias Nobank.Users

  defdelegate create(params), to: Users.Create, as: :call
  defdelegate get(id), to: Users.Get, as: :call
  defdelegate update(id, params), to: Users.Update, as: :call
  defdelegate delete(id), to: Users.Delete, as: :call
end
