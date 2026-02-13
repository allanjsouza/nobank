defmodule Nobank.UserFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Nobank.Repo

  alias Nobank.Users.User

  def user_factory do
    %User{
      name: "John Doe",
      email: "john.doe@example.com",
      password: "qwerty#123",
      password_hash: "Argon2.hash_pwd_salt(\"qwerty#123\")",
      postal_code: "11000000"
    }
  end
end
