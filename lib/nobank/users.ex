defmodule Nobank.Users do
  alias Nobank.Users

  defdelegate create(params), to: Users.Create, as: :call
end
