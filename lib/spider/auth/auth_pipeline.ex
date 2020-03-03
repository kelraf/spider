defmodule Spider.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :Spider,

    module: Spider.Guardian,
    error_handler: Spider.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource

end
