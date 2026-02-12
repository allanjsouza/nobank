defmodule NobankWeb.UsersJSON do
  alias Nobank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  def show(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}) do
    %{
      message: "User updated successfully",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      password: "REDACTED",
      postal_code: user.postal_code
    }
  end
end
