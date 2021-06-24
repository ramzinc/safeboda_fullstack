defmodule SafebodaFullstackWeb.Api.Admin.DriverView do
  use SafebodaFullstackWeb, :view

  def render("driver.json", %{driver: driver}) do
    %{
      data: %{
        id: driver.id,
        suspended: driver.suspended,
        name: driver.first_name <> " " <> driver.last_name,
        phone_numer: driver.phone_number
      }
    }
  end

  def render("drivers.json", %{drivers: drivers}) do
    render_many(drivers, __MODULE__, "driver_list.json")
  end

  def render("driver_list.json", %{driver: driver}) do
    %{
      id: driver.id,
      suspended: driver.suspended,
      name: driver.first_name <> " " <> driver.last_name,
      phone_number: driver.phone_number
    }
  end

  # def render("suspend.json", maps) do

  # end
end
