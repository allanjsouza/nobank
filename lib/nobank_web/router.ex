defmodule NobankWeb.Router do
  use NobankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NobankWeb do
    pipe_through :api

    get "/", HomeController, :index

    resources "/users", UsersController, only: [:create, :show, :update, :delete]
    post "/users/login", UsersController, :login

    resources "/accounts", AccountsController, only: [:create]
    post "/accounts/transaction", AccountsController, :transaction
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:nobank, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: NobankWeb.Telemetry
    end
  end
end
