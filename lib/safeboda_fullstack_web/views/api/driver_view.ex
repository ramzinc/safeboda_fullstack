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

  # def render("suspend.json", maps) do

  # end
end
