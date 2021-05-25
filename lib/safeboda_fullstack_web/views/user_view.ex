defmodule SafebodaFullstackWeb.UserView do
  use SafebodaFullstackWeb, :view
  alias SafebodaFullstackWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      phone_number: user.phone_number,
      status: user.status,
      user_type: user.user_type,
      email: user.email}
  end
end
