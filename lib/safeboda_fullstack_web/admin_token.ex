defmodule SafebodaFullstackWeb.AdminToken do
  use Guardian, otp_app: :safeboda_fullstack

  def subject_for_token(admin, _claims) do
    {:ok, admin}
  end

  def resource_from_claims(claims) do
    res = claims["sub"]
    IO.inspect(res)
    {:ok, res}
  end
end
