defmodule SafebodaFullstackWeb.Api.AdminController do
  use SafebodaFullstackWeb, :controller

  alias SafebodaFullstack.Admin
  alias SafebodaFullstackWeb.AdminToken

  def login(conn, %{"email" => email, "password" => password}) do
    case Admin.authenticate_admin_user(%Admin{}, email, password) do
      %Admin{} = admin ->
        {:ok, token, _claims} = AdminToken.encode_and_sign(admin)
        IO.inspect(conn)
        json(Plug.Conn.put_status(conn, 201), %{"token" => token})

      error ->
        json(conn, %{"error" => error})
    end
  end
end
