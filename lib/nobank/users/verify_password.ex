defmodule Nobank.Users.VerifyPassword do
  alias Nobank.Users

  def call(%{"email" => email, "password" => password}) do
    with {:ok, user} <- Users.get_by(email: email),
         true <- verify_pass(user, password) do
      {:ok, user}
    end
  end

  defp verify_pass(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      false -> {:error, :unauthorized}
      otherwise -> otherwise
    end
  end
end
