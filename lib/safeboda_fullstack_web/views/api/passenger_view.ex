defmodule SafebodaFullstackWeb.Api.Admin.PassengerView do
  use SafebodaFullstackWeb, :view

  def render("passenger.json", %{passenger: passenger}) do
    %{
      data: %{
        id: passenger.id,
        name: passenger.first_name <> " " <> passenger.last_name,
        phone_number: passenger.phone_number
      }
    }
  end
end
