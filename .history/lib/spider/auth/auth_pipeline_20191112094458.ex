defmodule Rental.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :Rental,

    module: Rental.Guardian,
    error_handler: Rental.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource

end
