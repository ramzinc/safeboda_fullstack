defmodule SafebodaFullstackWeb.Api.Admin.PassengerController do
  use SafebodaFullstackWeb, :controller
  alias SafebodaFullstack.Accounts

  def new(conn, params) do
    params = Map.put(params, "user_type", "passenger")
    passenger = Accounts.create_user(params)
    render(conn, "passenger.json", %{passenger: passenger})
  end
end
