defmodule SafebodaFullstackWeb.Router do
  use SafebodaFullstackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SafebodaFullstackWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_authenticated_as_admin do
    plug SafebodaFullstackWeb.GuardPipeline
  end

  scope "/", SafebodaFullstackWeb do
    pipe_through :browser

    # live "/", PageLive, :index
    get "/", PageController, :index
  end

  scope "/", SafebodaFullstackWeb.Api do
    pipe_through :api

    post("/login", AdminController, :login)

    scope "/admin", Admin do
      pipe_through(:ensure_authenticated_as_admin)
      get("/drivers", DriverController, :index)
      post("/driver", DriverController, :new)
      post("/driver/:driver_id/suspend", DriverController, :suspend)
      delete("/driver/:driver_id/suspend", DriverController, :unsuspend)
      post("/passenger", PassengerController, :new)
      post("/ride/:ride_id/stop", RideController, :stop)
      post("/ride/:passenger_id/:driver_id", RideController, :new)
      get("/rides/ongoing", RideController, :ongoing)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", SafebodaFullstackWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SafebodaFullstackWeb.Telemetry
    end
  end
end
