defmodule Nobank.Users do
  alias Nobank.Users

  defdelegate create(params), to: Users.Create, as: :call
  defdelegate show(id), to: Users.Show, as: :call
  defdelegate update(id, params), to: Users.Update, as: :call
end
