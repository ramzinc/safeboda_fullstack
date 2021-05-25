defmodule SafeBodaFullStackWeb.AdminView do
  use SafebodaFullstackWeb, :view

  def render("admin.json", %{token: token}) do
    %{token: token}
  end
end
