defmodule SafebodaFullstackWeb.GuardPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :safeboda_fullstack,
    error_handler: SafebodaFullstackWeb.GuardErrorHandler,
    module: SafebodaFullstackWeb.AdminToken

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}

  plug Guardian.Plug.VerifyHeader, realm: "Bearer", claims: %{"typ" => "access"}

  plug Guardian.Plug.LoadResource, allow_blank: true

  plug Guardian.Plug.EnsureAuthenticated, realm: "Bearer", claims: %{"typ" => "access"}
end
