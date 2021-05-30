defmodule SafebodaFullstackWeb.AdminControllerTest do
  use SafebodaFullstackWeb.ConnCase
  alias SafebodaFullstackWeb.AdminToken

  @admin_logins %{
    email: "mpiima@protonmail.com",
    password: "B3stp4ssw0rd"
  }

  @driver_details %{
    first_name: "first_test",
    last_name: "last_test",
    phone_number: "+256700000000"
  }

  setup %{conn: conn} do
    {:ok, token, _claims} = AdminToken.encode_and_sign(AdminToken, @admin_logins)

    conn = put_req_header(conn, "authorization", "Bearer" <> " " <> token)
    {:ok, conn: conn}
  end

  describe "Admin Create Driver" do
    test "POST /admin/driver", %{conn: conn} do
      conn = post(conn, "/admin/driver", @driver_details)
      assert conn.status == 200
    end
  end
end
