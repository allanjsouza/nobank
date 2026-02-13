defmodule NobankWeb.UsersControllerTest do
  @moduledoc false
  use NobankWeb.ConnCase, async: true

  import Nobank.UserFactory

  alias Nobank.Repo
  alias Nobank.Users.User

  describe "create/2" do
    test "successfully creates an user and responds with data", %{conn: conn} do
      params = params_for(:user)

      response = post(conn, ~p"/api/users", params) |> json_response(:created)

      assert %{
               "data" => %{
                 "email" => "john.doe@example.com",
                 "id" => user_id,
                 "name" => "John Doe",
                 "password" => "REDACTED",
                 "postal_code" => "11000000"
               },
               "message" => "User created successfully"
             } = response

      assert %User{} = Repo.get(User, user_id)
    end

    test "when params are invalid it responds with errors", %{conn: conn} do
      invalid_params = %{
        name: "Jo",
        email: "jo.example.com",
        postal_code: "11000-000"
      }

      response = post(conn, ~p"/api/users", invalid_params) |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "email" => ["has invalid format"],
          "name" => ["should be at least 3 character(s)"],
          "password" => ["can't be blank"],
          "postal_code" => ["has invalid format"]
        }
      }

      assert expected_response == response
    end
  end

  describe "show/2" do
    test "successfully responds with user data", %{conn: conn} do
      %User{id: user_id} = insert(:user)

      response = get(conn, ~p"/api/users/#{user_id}") |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "email" => "john.doe@example.com",
          "id" => user_id,
          "name" => "John Doe",
          "password" => "REDACTED",
          "postal_code" => "11000000"
        }
      }

      assert expected_response == response
    end

    test "when user does not exists it responds with not_found error", %{conn: conn} do
      response = get(conn, ~p"/api/users/999999") |> json_response(:not_found)

      expected_response = %{
        "error" => "Not found",
        "path" => "/api/users/999999",
        "status" => 404
      }

      assert expected_response == response
    end
  end

  describe "update/2" do
    test "successfully updates an user and responds with updated data", %{conn: conn} do
      %User{id: user_id} = insert(:user)

      update_params =
        params_for(:user,
          name: "John",
          email: "john_doe@example.com",
          password: "qwerty123",
          postal_code: "22000000"
        )

      response = put(conn, ~p"/api/users/#{user_id}", update_params) |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "email" => "john_doe@example.com",
          "id" => user_id,
          "name" => "John",
          "password" => "REDACTED",
          "postal_code" => "22000000"
        },
        "message" => "User updated successfully"
      }

      assert expected_response == response
    end

    test "when user does not exists it responds with not_found error", %{conn: conn} do
      update_params =
        params_for(:user,
          name: "John",
          email: "john_doe@example.com",
          password: "qwerty123",
          postal_code: "22000000"
        )

      response = put(conn, ~p"/api/users/999999", update_params) |> json_response(:not_found)

      expected_response = %{
        "error" => "Not found",
        "path" => "/api/users/999999",
        "status" => 404
      }

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "successfully deletes the user with given id and responds with no_content", %{conn: conn} do
      %User{id: user_id} = insert(:user)

      response = delete(conn, ~p"/api/users/#{user_id}") |> json_response(:no_content)

      expected_response = nil
      assert expected_response == response
    end

    test "when user does not exists, returns a not_found error", %{conn: conn} do
      response = delete(conn, ~p"/api/users/999999") |> json_response(:not_found)

      expected_response = %{
        "error" => "Not found",
        "path" => "/api/users/999999",
        "status" => 404
      }

      assert expected_response == response
    end
  end
end
