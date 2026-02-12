defmodule Nobank.Users do
  alias Nobank.Users

  defdelegate create(params), to: Users.Create, as: :call
  defdelegate show(id), to: Users.Show, as: :call
end
