defmodule SafeBodaFullStackWeb.GuardPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :safeboda_fullstack,
    error_handler: SafeBodaFullStackWeb.GuardErrorHandler,
    module: SafeBodaFullStackWeb.AdminToken

  #  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}

  plug Guardian.Plug.VerifyHeader, realm: "Bearer", claims: %{"typ" => "access"}

  plug Guardian.Plug.LoadResource, allow_blank: true
end
