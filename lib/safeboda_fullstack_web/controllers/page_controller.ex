defmodule SafebodaFullstackWeb.PageController do
  use SafebodaFullstackWeb, :controller

  def index(conn, _params) do
    # conn
    # |> put_resp_header("content-type", "text/html; charset=utf-8")
    # #|> Plug.Conn.send_file(200, "priv/static/index.html")
    # |> halt()
    #
    render(conn, "index.html")
  end
end
