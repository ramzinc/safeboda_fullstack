defmodule SafebodaFullstackWeb.Api.Admin.DriverController do
  use SafebodaFullstackWeb, :controller
  alias SafebodaFullstack.Accounts

  def new(conn, params) do
    params = Map.put(params, "user_type", "driver")
    driver = Accounts.create_user(params)
    IO.inspect(driver)
    render(conn, "driver.json", %{driver: driver})
  end

  def suspend(conn, %{"driver_id" => driver_id}) do
    status = Accounts.suspend_driver(driver_id)
    #    conn = put_status(conn, status)
    send_resp(conn, status, "")
  end

  def unsuspend(conn, %{"driver_id" => driver_id}) do
    status = Accounts.unsuspend_driver(driver_id)
    send_resp(conn, status, "")
  end
end
